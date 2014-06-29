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

persistent_package = {
    0 => "netfilter-persistent", # jessie/sid
    7 => "iptables-persistent",  # wheezy
    8 => "netfilter-persistent"  # jessie(for future)
}[node["platform_version"].to_i]

apt_package persistent_package do
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

service persistent_package do
    action [:enable, :restart]
end
