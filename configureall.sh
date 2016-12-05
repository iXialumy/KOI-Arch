#!/bin/bash
httpd='/opt/lampp/etc/httpd.conf';

#fish config
chsh -s /usr/bin/fish && sudo chsh -s /usr/bin/fish
sudo ln -s ~/Dropbox/Linux/configs/config.fish ~/.config/fish/config.fish;

#intellij
sudo ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea.sh;

#lammp 
sudo chown $USER /opt/lampp/htdocs/ && sudo chmod 755 /opt/lampp/htdocs/ && ln -s ~/Dropbox/Uni/3.\ Semester/datenbanken/ /opt/lampp/htdocs/datenbanken;
sudo sed -i -e 's/User daemon/User '$USER'/g' $httpd && sudo sed -i -e 's/Group daemon/Group users/g' $httpd;

#git
mkdir ~/gitprojects
git config --global user.name "Jonas Grebe" ;and git config --global user.email jgrebe@techfak.uni-bielefeld.de
git clone https://tdpe.techfak.uni-bielefeld.de/git/tdpe-ws-2016-jgrebe ~/gitprojects

