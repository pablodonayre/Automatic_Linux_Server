sudo apt-get update && sudo apt-get upgrade -y && sudo apt autoremove -y;

sudo apt-get install language-pack-es -y;

echo LANG=es_ES.UTF-8 >> /etc/default/locale;
echo LC_ALL=es_ES.UTF-8 >> /etc/default/locale;
echo LANGUAGE=es_ES >> /etc/default/locale;

echo LANG=es_ES.UTF-8 >> /etc/environment;
echo LC_ALL=es_ES.UTF-8 >> /etc/environment;
echo LANGUAGE=es_ES >> /etc/environment;

sudo update-locale es_ES.UTF-8;
sudo locale;

sudo reboot;
