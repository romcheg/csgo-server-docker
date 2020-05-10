#! /bin/bash

set -eux

source "${CONF_DIR}/provisioning_config.sh"

download_and_unpack() {
    mkdir -p "${STEAM_CMD_DIR}"
    pushd "${STEAM_CMD_DIR}"

    wget -qO- "${STEAM_DL_URL}" | tar zxf -
    chown -R "${STEAM_USER}:${STEAM_USER}" "${STEAM_USER_HOMEDIR}"

    rm -f "*.tar.gz"
    popd
}

create_user() {
    groupadd "${STEAM_USER}"
    useradd -g "${STEAM_USER}" -d "${STEAM_USER_HOMEDIR}" -m "${STEAM_USER}"
}

install_csgo() {
    su "${STEAM_USER}" -c "\"${STEAM_CMD_DIR}/steamcmd.sh\" +runscript \"${STEAM_USER_HOMEDIR}/update_csgo.txt\""
}

move_user_scripts() {
    local entrypoint_script_dst="${STEAM_USER_HOMEDIR}/entrypoint.sh"
    local update_csgo_dst="${STEAM_USER_HOMEDIR}/update_csgo.txt"

    mv "${PROVISIONING_DIR}/entrypoint.sh" "${entrypoint_script_dst}"
    mv "${PROVISIONING_DIR}/update_csgo.txt" "${update_csgo_dst}"

    chown ${STEAM_USER}:${STEAM_USER} "${entrypoint_script_dst}"
    chown ${STEAM_USER}:${STEAM_USER} "${update_csgo_dst}"
    
    chmod 0500 "${entrypoint_script_dst}"
}

# NOTE(romcheg): This is to work around a nasty issue in srcds script.
link_files() {
    ln "${STEAM_CMD_DIR}/steamcmd.sh" "${STEAM_CMD_DIR}/steam.sh"
    ln "${STEAM_CMD_DIR}/linux32/steamcmd" "${STEAM_CMD_DIR}/linux32/steam"

    chown -R ${STEAM_USER}:${STEAM_USER} "${STEAM_CMD_DIR}"
}

server_config() {
    local config_dst="${CS_GO_DIR}/csgo/cfg/server.cfg"

    ln "${CONF_DIR}/server.cfg" "${config_dst}"
    chown ${STEAM_USER}:${STEAM_USER} "${config_dst}"
}

create_user
move_user_scripts
download_and_unpack
install_csgo
server_config
link_files
