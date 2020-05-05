#! /bin/bash
set -uex

STEAM_USER=${STEAM_USER:-"steam"}
STEAM_USER_HOMEDIR=${STEAM_USER_HOMEDIR:="/home/$STEAM_USER"}
STEAM_CMD_DIR=${STEAM_CMD_DIR:-"$STEAM_USER_HOMEDIR/steamcmd"}
CS_GO_DIR=${CS_GO_DIR:-"$STEAM_USER_HOMEDIR/csgo"}

STEAM_DL_URL='https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz'
STEAM_SCRIPT="${STEAM_PROVISIONING_SCRIPT}"
ENTRYPOINT_SCRIPT="${CS_ENTRYPOINT_SCRIPT}"
ENTRYPOINT_SCRIPT_DST="${CS_ENTRYPOINT_SCRIPT_DST}"


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
    su "${STEAM_USER}" -c "\"${STEAM_CMD_DIR}/steamcmd.sh\" +runscript \"${STEAM_SCRIPT}\""
}

move_entrypoint_script() {
    mv "${ENTRYPOINT_SCRIPT}" "${ENTRYPOINT_SCRIPT_DST}"
}

create_user
download_and_unpack
install_csgo
move_entrypoint_script