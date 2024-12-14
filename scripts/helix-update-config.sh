#!/bin/bash
# Assumes my folder structure for my devices

echo "1. Copy from device to repo"
echo "2. Update device from repo"
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


copy_from_device() {
  if [[ "$isWindows" ]]; then
    echo "Copying from windows device to repo..."
    robocopy "%AppData%\helix" "C:\Users\%USERNAME%\source\config\helix" /mir /xd ".git"
  elif [[ "$isMacOrLinux" ]]; then
    echo "Copying from mac/linux device to repo..."
    rsync -rv --exclude '**/.git/' ~/.config/helix/ ~/src/config/helix/
  fi
}

copy_from_repo() {
  if [[ "$isWindows" ]]; then
    echo "Copying from repo to windows device..."
    robocopy "C:\Users\%USERNAME%\source\config\helix" "%AppData%\helix" /mir /xd ".git"
  elif [[ "$isMacOrLinux" ]]; then
    echo "Copying from repo to mac/linux device..."
    rsync -rv --exclude '**/.git/' ~/src/config/helix/ ~/.config/helix/
  fi
}


case "$choice" in 
  1)
    copy_from_device
    echo "Completed copy to repo"
    break
    ;;
  2)
    echo "Updating device from repo"
    echo "Completed copy from repo"
    break
    ;;
  *)
    echo "Unexpected input. Exiting..."
esac
