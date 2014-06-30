#
# Cookbook Name:: radvd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "radvd"

template "/etc/radvd.conf" do
    source "radvd.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :interfaces => node[cookbook_name]["interfaces"]
        })

    action :create
end

if node[cookbook_name]["enable"] then
    service "radvd" do
        action [:enable, :restart]
    end
else
    service "radvd" do
        action [:disable, :stop]
    end
end
