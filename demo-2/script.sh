#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# Adding Node.js repository
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

# Refresh our packages list with the new repositories
sudo apt-get update

# Install our dependencies for compiiling Ruby along with Node.js and Yarn
sudo apt-get install --yes \
  git-core \
  curl \
  zlib1g-dev \
  build-essential \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libsqlite3-dev \
  sqlite3 libxml2-dev \
  libxslt1-dev \
  libcurl4-openssl-dev \
  software-properties-common \
  libffi-dev \
  dirmngr \
  gnupg \
  apt-transport-https \
  ca-certificates \
  nodejs

echo "Installing yarn"
sudo npm install -g yarn

echo "Installing rbenv"
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

echo "Installing ruby-build"
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars

echo "Exporting PATH env variable"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

echo "Installing ruby"
rbenv install 2.4.10
rbenv global 2.4.10

echo "Ruby installed"
rbenv rehash

eval "$(rbenv init -)"
echo "Getting versions"
rbenv versions
ruby -v

# Install bundler

echo "Installing bundler"
gem install bundler -v 1.17.3

