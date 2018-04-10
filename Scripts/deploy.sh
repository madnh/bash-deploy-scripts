#!/bin/bash

# Config here
# --------------------


PUBLIC_REMOTE=''


# --------------------
# DO NOT EDIT FROM HERE
# until you known what are you doing ;)
# --------------------

clear

APP_DIR="$(realpath `dirname "$0"`)"
APP_BASE_MODULE_DIR="${APP_DIR}/_"
APP_SERVERS_DIR="${APP_DIR}/servers"
APP_TASKS_DIR="${APP_DIR}/tasks"


. "$APP_BASE_MODULE_DIR/setting.sh"
. "$APP_BASE_MODULE_DIR/utils_text.sh"
. "$APP_BASE_MODULE_DIR/functions.sh"
. "$APP_BASE_MODULE_DIR/banner.sh"

. "$APP_BASE_MODULE_DIR/init.sh"


#
# Do tasks
# ----------------------------------------

_check_tasks ${POSITIONAL[@]}


for TASK in "${POSITIONAL[@]}"
do
    _task "${TASK}"
done

echo
echo '----------------------'
echo
_message success " Completed ${ICON_BEER_CLICKING}   "
echo
echo
