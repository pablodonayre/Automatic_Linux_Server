# Ubuntu x64: 18.04

# -------------------------------------------------------------------
# Update and Upgrade the System

	sudo apt-get update && sudo apt-get upgrade -y &&
	sudo apt autoremove -y;

	export $(cat .env | grep -v "#" | xargs)
# -------------------------------------------------------------------
# Firewall

	# NI= Install UFW (Firewall)
	sudo apt-get install ufw -y;
	sudo ufw status &&
	sudo ufw default deny incoming &&
	sudo ufw default allow outgoing &&
	#sudo ufw allow 'Nginx HTTP' &&
	# www required to accept domains on port 80
	sudo ufw allow www &&
	# 443/tcp required to accept domains on port 443
	sudo ufw allow 443/tcp &&
	#sudo ufw allow ssh &&
	sudo ufw --force enable;
	ufw_status=$(sudo ufw status);
	echo -e "\e[31mUFW: $ufw_status\e[39m";


# -------------------------------------------------------------------
# Desktop

	# Add Nautilus Admin to the Nautilus Right-Click Menu
	#sudo apt-get install nautilus-admin -y;

	# Classic GNOME Flashback in Ubuntu 18.04 LTS
	sudo apt-get install gnome-session-flashback -y;

	# Cinnamon Desktop
	# sudo add-apt-repository universe;
	# sudo apt install cinnamon-desktop-environment lightdm;

	# Python3
	# sudo apt-get install python3 -y;
	# py3_version=$(python3 --version);
	# echo -e "\e[31m$py3_version\e[39m";
	# sudo apt-get install python3-pip -y;
	# pip3_version=$(pip3 --version);
	# echo -e "\e[31m$pip3_version\e[39m";

	# Install Midnight Commander
	sudo apt-get install mc -y;
	mc_version=$(mc --version);
	echo -e "\e[31m$mc_version\e[39m";

	# Terminal = TERMINATOR
	sudo apt-get install terminator -y;
	terminator_version=$(terminator --version);
	echo -e "\e[31mTerminator Version: $terminator_version\e[39m";

# -------------------------------------------------------------------
# Developer Tools

	# Gparted
	sudo apt-get install gparted -y;

	# NI= Install GIT
	sudo apt-get install git -y;
	git config --global user.email $ENV_GIT_EMAIL;
	git config --global user.name $ENV_GIT_USER_NAME;
	git_version=$(git --version);
	echo -e "\e[31m$git_version\e[39m";

	# Install CURL
	sudo apt-get install curl -y;

	# Install Docker
	# https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";

	sudo apt-get install -y docker.io;
	docker_version=$(docker --version);
	echo -e "\e[31m$docker_version\e[39m";

	# Install Docker Compose
	# https://docs.docker.com/compose/install/
	sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose;

	sudo chmod +x /usr/local/bin/docker-compose;
	docker_compose_version=$(docker-compose --version);
	echo -e "\e[31m$docker_compose_version\e[39m";

	# Install NodeJS (version 10) and NPM
	sudo apt install curl &&
	curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - &&
	sudo apt install nodejs &&
	echo “Node version: ” &&
	node -v &&
	echo “npm version: ” &&
	npm -v;

        # Install NVM
        # https://www.digitalocean.com/community/tutorials/como-instalar-node-js-en-ubuntu-18-04-es
	curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh;
	bash install_nvm.sh;
	source ~/.profile;
	nvm ls-remote;
	


	# Install Angular (specific version)
	sudo npm install -g @angular/cli@7.3.7 &&
	ng --version;

	# Install Typescript
	sudo npm install -g typescript &&
	tsc --version;

	sudo apt-get install -y gcc g++ make;
	sudo apt-get install -y filezilla;
	sudo apt-get install -y kdiff3;

	sudo snap install sublime-text --classic;
	sudo snap install code --classic;
	sudo snap install atom --classic;
	#sudo snap install eclipse --classic;
	sudo snap install -y gitkraken --classic;
	sudo snap install -y notepadqq;
	sudo snap install -y postman;
	sudo snap install -y pycharm-community --classic;
	sudo snap install -y sqlitebrowser;
	sudo apt-get install -y emma;
		
	sudo snap install -y poedit;
	sudo snap install skype --classic;
	sudo snap install nmap;
	sudo snap install telegram-desktop;
	sudo snap install zoom-client;

	sudo snap install video-downloader;
	sudo snap install obs-studio;

	# Arduino must be installed from source (original web page)
	sudo snap install arduino;
	sudo usermod -a -G dialout $USER;

	# Cubic (Custom Ubuntu ISO Creator). Is a GUI wizard to create a customized Ubuntu Live ISO image
	#sudo apt-add-repository -y ppa:cubic-wizard/release;
	#sudo apt update;
	#sudo apt install -y cubic;

	
	cd Downloads;

	# TeamViewer
	wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb;
	sudo apt install -y ./teamviewer_amd64.deb;

	# Google Chrome
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb;
	sudo apt install ./google-chrome-stable_current_amd64.deb;

	# Virtualbox
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -;
	sudo add-apt-repository "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib";
	sudo apt update && sudo apt install -y virtualbox-6.1;

	# WPS Office
	wget http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/9615/wps-office_11.1.0.9615.XA_amd64.deb;
	sudo dpkg -i wps-office_*.deb;
	sudo apt-get -f install;

# -------------------------------------------------------------------
# Remove things:

	sudo apt-get remove -y --purge --auto-remove libreoffice*
	sudo apt-get remove -y --purge --auto-remove hexchat;
	sudo apt remove -y --purge --auto-remove pidgin;
	sudo apt remove -y --purge --auto-remove thunderbird;

	sudo apt-get clean

# -------------------------------------------------------------------
# Manual installation

	# wps


# -------------------------------------------------------------------
# Finally
	sudo apt-get update && sudo apt-get upgrade -y &&
	sudo apt autoremove -y;

	sudo reboot;
