#!/bin/sh

apt-get update
apt-get install ruby make sudo git-core -y

gem install chef --no-rdoc --no-ri
