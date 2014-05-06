#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

apt_package "iptables" do
    action :install
end

apt_package "iptables-persistent" do
    action :install
end

template "/etc/iptables/rules.v4" do
    source "rules.v4.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :filter => node["iptables"]["filter"],
            :nat => node["iptables"]["nat"]
        })
    action :create
end

service "iptables-persistent" do
    action :restart
end
