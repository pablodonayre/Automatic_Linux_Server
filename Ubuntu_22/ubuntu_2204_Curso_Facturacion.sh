#!/bin/bash

#
#
## Master-Coders
## Tested on Ubuntu 22.04 (on Digital Ocean's VPS)
## git clone git@github.com:pablodonayre/Automatic_Linux_Server.git
## The use od "sudo" if you are root its not required
#  


#Load COLORS library:
    #source cecho.sh
    cecho(){
        RED="\033[0;31m"
        GREEN="\033[0;32m"  # <-- [0 means not bold
        YELLOW="\033[1;33m" # <-- [1 means bold
        CYAN="\033[1;36m"
        # ... Add more colors if you like

        NC="\033[0m" # No Color

        # printf "${(P)1}${2} ${NC}\n" # <-- zsh
        echo ""
        printf "${!1}#---------------------------------------------------------------------------- ${NC}\n" # <-- bash
        printf "${!1}${2} ${NC}\n" # <-- bash
    }


# Verify if environment file exists and import it
    if [ ! -f .env ]; then
        cecho "RED" "File .env not found!"
        exit 0
    fi
    export $(cat .env | grep -v "#" | xargs);


# Avoid interactive installation (restart) Ubuntu 22.04
    # https://stackoverflow.com/questions/73397110/how-to-stop-ubuntu-pop-up-daemons-using-outdated-libraries-when-using-apt-to-i
    sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf;


# Update and Upgrade the System
    cecho "GREEN" "Master-Coders: Update & Upgrade"
    sudo apt-get update && sudo apt-get upgrade -y &&
    sudo apt autoremove -y;


# NI= Install GIT
    cecho "GREEN" "Master-Coders: Install git"
    sudo apt-get install git -y;


# NI= Install UFW (Firewall)
    cecho "GREEN" "Master-Coders: Install and configure ufw"
    sudo apt-get install ufw -y;
    sudo ufw status &&
    sudo ufw default deny incoming &&
    sudo ufw default allow outgoing &&
    #sudo ufw allow 'Nginx HTTP' &&
    # www required to accept domains on port 80
    sudo ufw allow www &&
    # 443/tcp required to accept domains on port 443
    sudo ufw allow 443/tcp &&
    sudo ufw allow ssh &&
    sudo ufw --force enable;


# Install Midnight Commander
    cecho "GREEN" "Master-Coders: Install mc"
    sudo apt-get install mc -y;


# Generate ssh-keygen
    cecho "GREEN" "Master-Coders: Create ssh-keygen for ROOT"
    ssh-keygen -t rsa -b 4096 -C "root-public-key" -P "" -f "/root/.ssh/id_rsa" -q &&
    eval $(ssh-agent -s) &&
    ssh-add ~/.ssh/id_rsa;
    echo "";
    cat /root/.ssh/id_rsa.pub;


# Create One User called "Developer"
    cecho "GREEN" "Master-Coders: Create new user= developer"

    new_user=developer;

    # Create new User and add it to Sudoers list
    adduser --disabled-password --gecos "" $new_user; 

    #Add a password
    echo $new_user:$ubuntu_password | chpasswd;
    echo $new_user'  ALL=(ALL:ALL) ALL' >> /etc/sudoers;

    # -p = creates dirs in the path if does not exists). 
    sudo mkdir -p /home/$new_user/.ssh &&
    sudo chmod 700 /home/$new_user/.ssh &&
    touch authorized_keys;


    # Generate ssh-keygen    
    cecho "GREEN" "Master-Coders: Create ssh-keygen for new user"
    ssh-keygen -t rsa -b 4096 -C "$new_user-public-key" -P "" -f "/home/$new_user/.ssh/id_rsa" -q &&
    echo "";
    cat /home/$new_user/.ssh/id_rsa.pub

    
    # To Copy the ssh authorized keys from root to the user (these keys were generated by digital ocean when creating the droplet)
    sudo cp /root/.ssh/authorized_keys /home/$new_user/.ssh/authorized_keys;
    #sudo touch /home/$new_user/.ssh/authorized_keys &&
    sudo chown -R $new_user:$new_user /home/$new_user/.ssh &&
    sudo chmod 644 /home/$new_user/.ssh/authorized_keys;
    
    cecho "GREEN" "Master-Coders: Authorized keys for new user"
    cat /home/$new_user/.ssh/authorized_keys;


# Install Fail2ban (Avoid Brute Force attack)
    cecho "GREEN" "Master-Coders: Install fail2ban"
    sudo apt-get install fail2ban -y;


# OpenSSL
    cecho "GREEN" "Master-Coders: Verify if openssl is installed (Required to get communicated with SUNAT servers)"
    openssl version


# Copy Automatic Commands to manage DOCKER
    cecho "GREEN" "Master-Coders: Install automatic commands to manage docker"

    # $new_user
    sudo mkdir /home/$new_user/Execute &&
    # This repository must be PUBLIC (to avoid the use of credentials)
    sudo git clone https://github.com/pablodonayre/Execute_Docker docker &&
    sudo mv docker /home/$new_user/Execute/ &&
    sudo chmod -R 755 /home/$new_user/Execute &&
    sudo chown -R $new_user:$new_user /home/$new_user/Execute &&
    echo alias dock-del-c=/home/$new_user/Execute/docker/docker-delete-containers.sh >> /home/$new_user/.bashrc &&
    echo alias dock-del-all=/home/$new_user/Execute/docker/docker-delete-all.sh >> /home/$new_user/.bashrc &&
    echo alias dock-del-img=/home/$new_user/Execute/docker/docker-delete-images.sh >> /home/$new_user/.bashrc &&
    echo alias dock-del-vol=/home/$new_user/Execute/docker/docker-delete-dangling_volumes.sh >> /home/$new_user/.bashrc;

# Copy the files of "TEST Project"
    cecho "GREEN" "Master-Coders: Download files of TEST PROJECT"
    sudo git clone https://github.com/pablodonayre/WebPage.git WebPage;
    sudo mv WebPage /home/$new_user/;
    sudo chmod -R 755 /home/$new_user/WebPage &&
    sudo chown -R $new_user:$new_user /home/$new_user/WebPage;


# Copy the files of "Facturacion Course Project"
    cecho "GREEN" "Master-Coders: Download files of Facturacion_Curso"


#------------------------------------------------------------------------------------------------------------------------
# Only For Ubuntu 22.04 (Take special care with this section !!)


# Install Docker
    cecho "GREEN" "Master-Coders: Install docker"

    # # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
    # sudo apt install apt-transport-https ca-certificates curl software-properties-common &&
    # curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&
    # echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&
    # sudo apt update &&
    # apt-cache policy docker-ce &&
    # sudo apt install -y docker-ce -y;

    # # Config sudo docker (avoid use of sudo)
    # sudo usermod -a -G docker $new_user;

    sudo apt install docker -y;
    sudo docker version;


# Install docker-compose
    cecho "GREEN" "Master-Coders: Install docker-compose"

    # # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04
    # # Dated Apr 26 2022: At the time of this writing, the most current stable version is 2.3.3.
    # mkdir -p ~/.docker/cli-plugins/ &&
    # curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose &&
    # chmod +x ~/.docker/cli-plugins/docker-compose &&
    sudo apt install docker-compose -y;
    docker compose version;




cecho "GREEN" "Master-Coders: Server Configuration finished"
echo ""
cecho "RED" "Go to: master-coders.com"
echo ""
cecho "RED" "Master-Coders: Reboot this server before you continue"
echo ""


