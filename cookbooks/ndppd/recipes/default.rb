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
