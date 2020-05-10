#! /bin/bash

set -uex

source "${CONF_DIR}/runtime_config.sh"

if [[ -z "${STEAM_ACCOUNT_TOKEN}" ]]; then
    echo "[ERROR] It is necessary to set STEAM_ACCOUNT_TOKEN variable."
    echo "[ERROR] See https://steamcommunity.com/dev/managegameservers for details."
    exit 1
fi

if [[ -z "${SRCDS_RCONPW}" ]]; then
    echo "[ERROR] It is necessary to set RCON password as SRCDS_RCONPW variable."
    exit 1
fi

if [[ "${SRCDS_PW}" == "0" ]]; then
    echo "[WARNING] It's reccomended to set server password as SRCDS_PW variable."
fi

${CS_GO_DIR}/srcds_run \
    -game csgo \
    -console \
    -autoupdate \
    -steam_dir ${STEAM_CMD_DIR} \
    -steamcmd_script ${STEAM_USER_HOMEDIR}/update_csgo.txt \
    -usercon \
    -tickrate ${SRCDS_TICKRATE} \
    -port ${SRCDS_PORT} \
    -net_port_try 1 \
    -maxplayers_override ${SRCDS_MAXPLAYERS} \
    +fps_max ${SRCDS_FPSMAX} \
    +tv_port ${SRCDS_TV_PORT} \
    +clientport ${SRCDS_CLIENT_PORT} \
    +game_type ${SRCDS_GAMETYPE} \
    +game_mode ${SRCDS_GAMEMODE} \
    +mapgroup ${SRCDS_MAPGROUP} \
    +map ${SRCDS_STARTMAP} \
    +sv_setsteamaccount ${STEAM_ACCOUNT_TOKEN} \
    +rcon_password ${SRCDS_RCONPW} \
    +sv_password ${SRCDS_PW} \
    +sv_region ${SRCDS_REGION}
