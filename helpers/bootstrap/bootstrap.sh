#!/bin/sh

apt-get update
apt-get install ruby ruby-dev make sudo git-core -y

gem update
gem install chef --no-rdoc --no-ri
