#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

echo "Installing nginx + passenger"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

# Change the passenger_ruby
sudo sed -i '/passenger_ruby/c\passenger_ruby /home/deploy/.rbenv/shims/ruby;' /etc/nginx/conf.d/mod-http-passenger.conf

sudo rm /etc/nginx/sites-enabled/default

sudo cp /tmp/webapp.conf /etc/nginx/sites-enabled/webapp.conf

mkdir -p $HOME/myapp/public
cp /tmp/index.html $HOME/myapp/public

sudo /etc/init.d/nginx restart
