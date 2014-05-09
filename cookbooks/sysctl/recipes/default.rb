#
# Cookbook Name:: sysctl
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sysctl.conf" do
    source "sysctl.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables(:variables => node[cookbook_name]["variables"])
    action :create
end

execute "reload sysctl.conf" do
    command "echo 'reload sysctl.conf(sudo /sbin/sysctl -p)'; sudo /sbin/sysctl -p"
    action :run
end

