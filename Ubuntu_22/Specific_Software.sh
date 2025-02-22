
# Install Composer
# https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md

sudo apt-get install composer -y;


# Install NodeJS (version 8) and NPM
sudo apt install curl &&
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - &&
sudo apt install nodejs &&
echo “Node version: ” &&
node -v &&
echo “npm version: ” &&
npm -v;


# Install Angular (specific version)
sudo npm install -g @angular/cli@7.3.7 &&
ng --version;

# Install Typescript
sudo npm install -g typescript &&
tsc --version;
