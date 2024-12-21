#!/bin/bash
# Assumes my folder structure for my devices
helix_config_source_unix=~/.config/helix/
helix_config_source_windows=$(cygpath -w "$HOME/AppData/Roaming/helix")
helix_config_repo_unix=~/src/config/helix/
helix_config_repo_windows=$(cygpath -w "$HOME/source/config/helix")

echo "1. Update repo"
echo "2. Install config"
read -p "Choose an action (1 or 2): " choice

# Helix has a different config location for windows
# Mac and Linux are the same
isWindows=""
isMacOrLinux=""

if [[ "$OSTYPE" == "linux"* || "$OSTYPE" == "darwin"* ]]; then
  isMacOrLinux="true"
elif [[ "$OSTYPE" == "msys"* ]]; then
  # git-bash
  isWindows="true"
fi

update_repo() {
  if [[ "$isWindows" ]]; then
    echo "Copying from windows device to repo..."
    robocopy  "$helix_config_source_windows" "$helix_config_repo_windows"
  elif [[ "$isMacOrLinux" ]]; then
    echo "Copying from mac/linux device to repo..."
    rsync -rv --exclude '**/.git/' $helix_config_source_unix $helix_config_repo_unix
  fi
}

install_on_device() {
  if [[ "$isWindows" ]]; then
    echo "Installing config on windows device..."
    robocopy "$helix_config_repo_windows" "$helix_config_source_windows"
  elif [[ "$isMacOrLinux" ]]; then
    echo "Installing config on mac/linux device..."
    rsync -rv --exclude '**/.git/' "$helix_config_repo_unix" "$helix_config_source_unix"   
  fi
}


case "$choice" in 
  1)
    update_repo
    echo "Updated helix on config repo"
    break
    ;;
  2)
    install_on_device
    echo "Installed helix config on device"
    break
    ;;
  *)
    echo "Unexpected input. Exiting..."
esac
