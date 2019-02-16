#!/bin/bash

echo ""
echo "***************************************************************************"
echo "**            ___  ____ ___ ____   _    ____ ____ ___  ____ ____         **"
echo "**            |  \ |__|  |  |__|   |    |  | |__| |  \ |___ |__/         **"
echo "**            |__/ |  |  |  |  |   |___ |__| |  | |__/ |___ |  \         **"
echo "**                                                                       **"
echo "**  Dataloder is a Salesforce supported Open Source project to help      **"
echo "**  Salesforce user to import and export data with Salesforce platform.  **"
echo "**  It requires Zulu OpenJDK 11 or higher to run.                        **"
echo "**                                                                       **"
echo "**  Github Project Url:                                                  **"
echo "**       https://github.com/forcedotcom/dataloader                       **"
echo "**  Salesforce Documentation:                                            **"
echo "**       https://help.salesforce.com/articleView?id=data_loader.htm      **"
echo "**                                                                       **"
echo "***************************************************************************"
echo ""


set version=45

echo You are about to create a directory in your home directory to install Dataloader program.
read -p "Please enter the directory name you want to use [dataloader]: " INSTALLATION_DIR_NAME
INSTALLATION_DIR_NAME=${INSTALLATION_DIR_NAME:-dataloader}
DL_FULL_PATH="$HOME/$INSTALLATION_DIR_NAME"
echo We will install it to this directory: $DL_FULL_PATH

# make sure there is a directory to install files
if [ -d "$DL_FULL_PATH" ]; then
    echo Directory $DL_FULL_PATH exists, we need to delete it in order to proceed the installation.
    echo Make sure you saved the data in $DL_FULL_PATH before deleting it.
    while true
    do
         read -r -p "Do you want to delete $DL_FULL_PATH? [Yes/No] " input
         case $input in
             [yY][eE][sS]|[yY])
                  echo "Deleting existing directory: $DL_FULL_PATH ... "
                  rm -rf "$DL_FULL_PATH"
                  break
              ;;
             [nN][oO]|[nN])
                echo  Quit dataloader installing script for now.
                exit
              ;;
             *)
             echo "Invalid input..."
             ;;
         esac
    done
fi

echo  Creating directory: $DL_FULL_PATH
mkdir -p "$DL_FULL_PATH"
SHELL_PATH=$(dirname "$0")
rsync -r "$SHELL_PATH"/.  "$DL_FULL_PATH"  --exclude='.*'
rm ~/"$INSTALLATION_DIR_NAME"/install.command
rm ~/"$INSTALLATION_DIR_NAME"/dataloader.ico
rm ~/"$INSTALLATION_DIR_NAME"/fileicon


sed -i '' 's|DATALODER_WORK_DIRECTORY|'"$DL_FULL_PATH"'|g'  "$DL_FULL_PATH"/dataloader.command

"$SHELL_PATH"/fileicon set  "$DL_FULL_PATH"/dataloader.command "$SHELL_PATH"/dataloader.ico

while true
do
     read -r -p "Do you want to create a link called DataLoader in your desktop? [Yes/No] " input
     case $input in
         [yY][eE][sS]|[yY])
              rm   $HOME/Desktop/DataLoader 2>/dev/null
              ln -s  "$DL_FULL_PATH/dataloader.command"  $HOME/Desktop/DataLoader
              "$SHELL_PATH"/fileicon set  $HOME/Desktop/DataLoader "$SHELL_PATH"/dataloader.ico 1>/dev/null

              break
          ;;
         [nN][oO]|[nN])
            echo  Quit dataloader installer
            exit
          ;;
         *)
         echo "Invalid input..."
         ;;
     esac
done