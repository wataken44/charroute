#
# Cookbook Name:: network-interfaces
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/network/interfaces" do
    source "network-interfaces.erb"
    owner "root"
    group "root"
    mode 0644
    variables(:interfaces => node[cookbook_name]["interfaces"])
    action :create
end

service "networking" do
    action :restart
end
