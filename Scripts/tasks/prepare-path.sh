#!/usr/bin/env bash

_message info "Prepare path: ${FG_YELLOW}${REMOTE_PUBLIC}${RESET}"

if ( _is_dry_run ); then
    _message info "Running in dry-run mode, bye!"
else
    _run_ssh_command "mkdir -p \"${REMOTE_PUBLIC}\""
    echo 'Complete'
fi
