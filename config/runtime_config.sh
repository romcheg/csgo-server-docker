#! /bin/bash

set -eux

source "${CONF_DIR}/common_config.sh"

STEAM_ACCOUNT_TOKEN=${STEAM_ACCOUNT_TOKEN:-""}
SRCDS_RCONPW=${SRCDS_RCONPW:-""}
SRCDS_PW=${SRCDS_PW:-"0"}

SRCDS_FPSMAX=${SRCDS_FPSMAX:-"300"}
SRCDS_TICKRATE=${SRCDS_TICKRATE:-"128"}
SRCDS_PORT=${SRCDS_PORT:-"27015"}
SRCDS_TV_PORT=${SRCDS_TV_PORT:-"27020"}
SRCDS_CLIENT_PORT=${SRCDS_CLIENT_PORT:-"27005"}
SRCDS_MAXPLAYERS=${SRCDS_MAXPLAYERS:-"15"}
SRCDS_STARTMAP=${SRCDS_STARTMAP:-"de_dust2"}
SRCDS_REGION=${SRCDS_REGION:-"3"}  # 3 --> Europe; https://developer.valvesoftware.com/wiki/Sv_region
SRCDS_MAPGROUP=${SRCDS_MAPGROUP:-"mg_active"}
SRCDS_GAMETYPE=${SRCDS_GAMETYPE:-"0"}
SRCDS_GAMEMODE=${SRCDS_GAMEMODE:-"1"}