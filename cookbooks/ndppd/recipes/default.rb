#
# Cookbook Name:: ndppd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service_action = 
    node['enable'] ? [:restart, :enable] : [:stop, :disable]


workdir = Chef::Config[:file_cache_path] + '/' + cookbook_name().to_s

arch = {
    "x86_64" => "amd64",
    "x86" => "i386",
}[node["kernel"]["machine"]]

package_name = "ndppd_0.2.3-1_#{arch}.deb"
filename = workdir + "/" + package_name

directory workdir do
    mode 0777
    action :create
end 

remote_file filename do 
    source "http://priv.nu/projects/ndppd/files/ndppd_0.2.3-1_#{arch}.deb"
    owner "root"
    group "root"
    mode 0644

    not_if "test -f #{filename}"

    action :create
end

package package_name do
    provider Chef::Provider::Package::Dpkg
    source filename

    action :install
    notifies :create, 'template[/etc/ndppd.conf]'
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

    action :nothing
    notifies service_action, 'service[ndppd]', :delayed
end

service "ndppd" do
    action service_action
end
