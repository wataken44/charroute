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

if node[cookbook_name]["v4"] then
    template "/etc/iptables/rules.v4" do
        source "rules.erb"
        owner "root"
        group "root"
        mode 0644
        variables({
                :filter => node[cookbook_name]["v4"]["filter"],
                :nat => node[cookbook_name]["v4"]["nat"]
            })
        action :create
    end
end

if node[cookbook_name]["v6"] then
    template "/etc/iptables/rules.v6" do
        source "rules.erb"
        owner "root"
        group "root"
        mode 0644
        variables({
                :filter => node[cookbook_name]["v6"]["filter"],
                :mangle => node[cookbook_name]["v6"]["mangle"]
            })
        action :create
    end
end

service "iptables-persistent" do
    action [:enable, :restart]
end
