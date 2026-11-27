#!/usr/bin/env bash
# nas-toggle.sh - toggle an NFSv4.1 share on ~/nas (mount if unmounted, unmount if mounted)
# Sends a desktop notification on success and on every error.

set -uo pipefail

# ---- Configuration ---------------------------------------------------------
NAS_IP="192.168.178.5"
NFS_EXPORT="/volume1"                 # path exported by the NAS (e.g. /volume1 or /volume1/media)
MOUNTPOINT="${HOME}/nas"
NFS_OPTS="nfsvers=4.1,proto=tcp,hard,lock,noatime,lookupcache=positive,_netdev"
MOUNT_TIMEOUT=20                      # seconds before a mount attempt is aborted
# ----------------------------------------------------------------------------

APP="NAS"
SOURCE="${NAS_IP}:${NFS_EXPORT}"

# Send a desktop notification (falls back to stderr if notify-send is missing)
notify() {
    local urgency="$1" title="$2" body="$3"
    if command -v notify-send >/dev/null 2>&1; then
        notify-send -a "$APP" -u "$urgency" -i drive-harddisk-network "$title" "$body" || true
    fi
    echo "[$title] $body" >&2
}

# Run a command with the privileges needed for mounting.
# Order: plain (works if fstab has a "user" entry), then sudo, then pkexec (no terminal).
run_mount_cmd() {
    if "$@" 2>/dev/null; then return 0; fi
    if [[ -t 0 ]]; then
        sudo "$@"
    elif sudo -n true 2>/dev/null; then
        sudo -n "$@"
    elif command -v pkexec >/dev/null 2>&1; then
        pkexec "$@"
    else
        return 1
    fi
}

do_mount() {
    mkdir -p "$MOUNTPOINT" || { notify critical "Mount failed" "Cannot create $MOUNTPOINT"; exit 1; }

    # Quick reachability check so we fail fast instead of hanging on a "hard" mount
    if command -v ping >/dev/null 2>&1 && ! ping -c1 -W2 "$NAS_IP" >/dev/null 2>&1; then
        notify critical "Mount failed" "NAS $NAS_IP is not reachable."
        exit 1
    fi

    local err
    if grep -qsE "[[:space:]]${MOUNTPOINT}[[:space:]]" /etc/fstab; then
        # An fstab entry exists for this mountpoint: let mount use it
        err="$(timeout "$MOUNT_TIMEOUT" bash -c "$(declare -f run_mount_cmd); run_mount_cmd mount '$MOUNTPOINT'" 2>&1)"
    else
        err="$(timeout "$MOUNT_TIMEOUT" bash -c "$(declare -f run_mount_cmd); run_mount_cmd mount -t nfs4 -o '$NFS_OPTS' '$SOURCE' '$MOUNTPOINT'" 2>&1)"
    fi
    local rc=$?

    if [[ $rc -eq 0 ]] && mountpoint -q "$MOUNTPOINT"; then
        notify normal "NAS mounted" "$SOURCE -> $MOUNTPOINT"
    elif [[ $rc -eq 124 ]]; then
        notify critical "Mount failed" "Timeout after ${MOUNT_TIMEOUT}s ($SOURCE)."
        exit 1
    else
        notify critical "Mount failed" "${err:-Unknown error (exit code $rc)}"
        exit 1
    fi
}

do_umount() {
    local err
    err="$(run_mount_cmd umount "$MOUNTPOINT" 2>&1)"
    if [[ $? -eq 0 ]] && ! mountpoint -q "$MOUNTPOINT"; then
        notify normal "NAS unmounted" "$MOUNTPOINT"
        return
    fi

    # Typical cause: a process still uses the share
    if [[ "$err" == *"busy"* || "$err" == *"in use"* || "$err" == *"belegt"* ]]; then
        notify critical "Unmount failed" "Share is busy. Close programs using $MOUNTPOINT and try again."
    else
        notify critical "Unmount failed" "${err:-Unknown error}"
    fi
    exit 1
}

# Toggle based on the current state
if mountpoint -q "$MOUNTPOINT"; then
    do_umount
else
    do_mount
fi
