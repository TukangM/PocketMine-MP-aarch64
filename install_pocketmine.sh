#!/bin/bash

# Variables
cpu=$(nproc)
distro_type=$(lsb_release -a | grep Description | awk -F: '{print $2}' | tr -d '\t')
user=$(whoami)

# Select Linux mode
echo "[Pocketmine-MP Installer Aarch64]"
echo "- Maintainer TukangM -"
echo "Select linux mode:"
echo "1.Termux*"
echo "2.LinuxFS (like ubuntu proot, debian in chroot, proot, raspberrypi)*"
echo "3.exit"
echo ""
echo "Termux: Pocketmine will be installed on /sdcard/pocketmine directory. So, allow Termux with termux-storage-setup command before selecting option 1."
echo "LinuxFS: Will be installed on the default directory /home/\$USER/pocketmine"
echo ""
echo "CPU Cores : [$cpu]"
echo "Type Distro : [$distro_type]"
echo ""

read -p "Choose Linux mode (1, 2, or 3): " linux_mode

case $linux_mode in
    1)
        # Termux
        echo "[Pocketmine-MP Installer Aarch64]"
        echo "- Maintainer TukangM -"
        echo "1.Stable Release (Precompiled php8 aarch64 from TukangM)"
        echo "2.Not Very Stable (run latest php amd64 from pmmp but run by box64) (currently compiling box64 on termux failed so option number 2 disabled)"
        echo ""
        read -p "Choose Termux option (1 or 3): " termux_option

        case $termux_option in
            1)
                # Termux Stable Release
                echo "[Pocketmine-MP Installer Aarch64]"
                echo "- Maintainer TukangM -"
                echo "Making dir on /sdcard and set dir on /sdcard/pocketmine"
                mkdir /sdcard/pocketmine && cd /sdcard/pocketmine && echo "Directory created."

                echo "Downloading last release pmmp"
                wget https://github.com/pmmp/PocketMine-MP/releases/latest/download/PocketMine-MP.phar && wget https://github.com/pmmp/PocketMine-MP/releases/latest/download/start.sh && echo "Downloads complete."

                echo "Downloading php8-aarch64"
                wget https://github.com/TukangM/php8-aarch64-builds/releases/download/php8.1.24/php-compiled-for-Linux_arm64_P5.zip && pkg install unzip && unzip php-compiled-for-Linux_arm64_P5.zip -d /sdcard/pocketmine && echo "PHP downloaded and extracted."

                echo "Process done. You can start your PocketMine-MP server with your arm64 CPU with bash start.sh [exit]"
                ;;
            2)
                # Termux Not Very Stable
                echo "Option 2 is currently disabled for Termux."
                ;;
            *)
                echo "Invalid option. Exiting."
                ;;
        esac
        ;;
    2)
        # LinuxFS
        echo "[Pocketmine-MP Installer Aarch64]"
        echo "- Maintainer TukangM -"
        echo "1.Stable Release (Precompiled php8 aarch64 From TukangM)"
        echo "2.Not Very Stable. sudo required (run latest php amd64 from pmmp but run by box64)"
        echo ""
        read -p "Choose LinuxFS option (1 or 2): " linuxfs_option

        case $linuxfs_option in
            1)
                # LinuxFS Stable Release
                echo "[Pocketmine-MP Installer Aarch64]"
                echo "- Maintainer TukangM -"
                echo "Making dir on /home/$USER/pocketmine and set dir on /home/$USER/pocketmine"
                mkdir /home/$USER/pocketmine && cd /home/$USER/pocketmine && echo "Directory created."

                echo "Downloading last release pmmp"
                wget https://github.com/pmmp/PocketMine-MP/releases/latest/download/PocketMine-MP.phar && wget https://github.com/pmmp/PocketMine-MP/releases/latest/download/start.sh && echo "Downloads complete."

                echo "Downloading php8-aarch64"
                wget https://github.com/TukangM/php8-aarch64-builds/releases/download/php8.1.24/php-compiled-for-Linux_arm64_P5.zip && sudo apt install unzip && unzip php-compiled-for-Linux_arm64_P5.zip -d /home/$USER/pocketmine && echo "PHP downloaded and extracted."

                echo "Process done. You can start your PocketMine-MP server with your arm64 CPU with bash start.sh [exit]"
                ;;
            2)
                # LinuxFS Not Very Stable
                echo "[Pocketmine-MP Installer Aarch64]"
                echo "- Maintainer TukangM -"
                echo "Compile box64 takes 15 minutes~ depending on your CPU speed"
                sudo apt update && sudo apt install wget git make cmake build-essential -y && git clone https://github.com/ptitSeb/box64 && cd box64 && mkdir build && cd build && cmake .. -D ARM_DYNAREC=ON -D CMAKE_BUILD_TYPE=RelWithDebInfo && make -j$cpu && sudo make install && echo "Box64 compiled and installed."

                echo "Making dir on /home/$USER/pocketmine and set dir on /home/$USER/pocketmine"
                mkdir /home/$USER/pocketmine && cd /home/$USER/pocketmine && echo "Directory created."

                echo "Downloading last release pmmp"
                wget https://github.com/pmmp/PocketMine-MP/releases/latest/download/PocketMine-MP.phar && wget https://github.com/pmmp/PocketMine-MP/releases/latest/download/start.sh && echo "Downloads complete."

                echo "Downloading php8-aarch64"
                wget https://github.com/TukangM/php8-aarch64-builds/releases/download/php8.1.24/php-compiled-for-Linux_arm64_P5.zip && sudo apt install unzip && unzip php-compiled-for-Linux_arm64_P5.zip -d /home/$USER/pocketmine && echo "PHP downloaded and extracted."

                echo "Process done. You can start your PocketMine-MP server with your arm64 CPU with bash start.sh [exit]"
                ;;
            *)
                echo "Invalid option. Exiting."
                ;;
        esac
        ;;
    3)
        # Exit
        echo "Exiting. Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid option. Exiting."
        ;;
esac
