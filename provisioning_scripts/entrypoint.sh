#! /bin/bash

set -uex

STEAM_ACCOUNT_TOKEN=${STEAM_ACCOUNT_TOKEN:-""}

if [[ -z "${STEAM_ACCOUNT_TOKEN}" ]]; then
    echo "It is necessary to set STEAM_ACCOUNT_TOKEN variable."
    echo "See https://steamcommunity.com/dev/managegameservers for details."
    exit 1
fi


srcds_run -game csgo \
    -console \
    -usercon \
    -net_port_try 1 \
    +game_type 0 \
    +game_mode 0 \
    +mapgroup mg_active \
    +map de_dust2 \
    +sv_setsteamaccount ${STEAM_ACCOUNT_TOKEN}
