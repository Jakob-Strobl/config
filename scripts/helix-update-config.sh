#!/bin/bash
# Only works on my mac rn

echo "1. Copy from device to repo"
echo "2. Update device from repo"
read -p "Choose an action (1 or 2): " choice

case "$choice" in 
  1)
    echo "Copying from device to repo..."
    rsync -rv --exclude '**/.git/' ~/.config/helix/ ~/src/config/helix
    echo "Completed copy to repo"
    break
    ;;
  2)
    echo "Updating device from repo"
    rsync -rv --exclude '**/.git/' ~/src/config/helix ~/.config/helix/
    echo "Completed copy from repo"
    break
    ;;
  *)
    echo "Unexpected input. Exiting..."
esac
