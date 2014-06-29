#
# Cookbook Name:: ndppd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

workdir = Chef::Config[:file_cache_path] + '/' + cookbook_name().to_s

directory workdir do
    mode 0777
    action :create
end 

arch = {
    "x86_64" => "amd64",
    "x86" => "i386",
}[node["kernel"]["machine"]]

remote_file workdir + "/ndppd_0.2.3-1_#{arch}.deb" do 
    source "http://priv.nu/projects/ndppd/files/ndppd_0.2.3-1_#{arch}.deb"
    owner "root"
    group "root"
    mode 0644

    action :create
end

template "/etc/ndppd.conf" do
    source "ndppd.conf.erb"
    owner "root"
    group "root"
    mode 0644

    variables({
            :route_ttl => node[cookbook_name]['route-ttl'],
            :proxies => node[cookbook_name]['proxies']
        })            

    action :create
end

service "ndppd" do
    if node[cookbook_name]["enable"] then
        action [:enable, :restart]
    else
        action [:disable, :stop]
    end
end
