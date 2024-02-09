# shellcheck disable=SC2148,SC1091

source /includes/colors.sh

function fresh_install_server() {
    ei ">>> Doing a fresh install of the gameserver...\n"
    if [[ -n $WEBHOOK_ENABLED ]] && [[ $WEBHOOK_ENABLED == "true" ]]; then
        send_install_notification
    fi
    "${STEAMCMD_PATH}"/steamcmd.sh +force_install_dir "$GAME_ROOT" +login anonymous +app_update 2394010 validate +quit
    es "> Done installing the gameserver\n"
}

function update_server() {
    if [[ -n $STEAMCMD_VALIDATE_FILES ]] && [[ $STEAMCMD_VALIDATE_FILES == "true" ]]; then
        ei ">>> Doing an update and validate of the gameserver files...\n"
        if [[ -n $WEBHOOK_ENABLED ]] && [[ $WEBHOOK_ENABLED == "true" ]]; then
            send_update_and_validate_notification
        fi
        "${STEAMCMD_PATH}"/steamcmd.sh +force_install_dir "$GAME_ROOT" +login anonymous +app_update 2394010 validate +quit
        es ">>> Done updating and validating the gameserver files\n"
    else
        ei ">>> Doing an update of the gameserver files...\n"
        if [[ -n $WEBHOOK_ENABLED ]] && [[ $WEBHOOK_ENABLED == "true" ]]; then
            send_update_notification
        fi
        "${STEAMCMD_PATH}"/steamcmd.sh +force_install_dir "$GAME_ROOT" +login anonymous +app_update 2394010 +quit
        es ">>> Done updating the gameserver files\n"
    fi
}
