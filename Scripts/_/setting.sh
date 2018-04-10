#!/usr/bin/env bash


#
# Include custom config
# ----------------------------

. "$APP_DIR/_config.sh"

#
# Default config here
# ----------------------------

DEFAULT_TASK="${DEFAULT_TASK:-default}"


IGNORE_FILE="${IGNORE_FILE:-excludes.txt}"

# Default is dry run mode
DRY_RUN="${DRY_RUN:-1}"

# Rync options
RSYNC_DELETEABLE=0

if [[ -z "${RSYNC_OPTION_PARAMETERS}" ]]; then
    RSYNC_OPTION_PARAMETERS="-az --force --progress"
fi
