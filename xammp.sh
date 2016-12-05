#!/bin/bash
httpd='/opt/lampp/etc/httpd.conf';
sudo chown $USER /opt/lampp/htdocs/ && sudo chmod 755 /opt/lampp/htdocs/ && ln -s ~/Dropbox/Uni/3.\ Semester/datenbanken/ /opt/lampp/htdocs/datenbanken;
sudo sed -i -e 's/User daemon/User '$USER'/g' $httpd && sudo sed -i -e 's/Group daemon/Group users/g' $httpd;



