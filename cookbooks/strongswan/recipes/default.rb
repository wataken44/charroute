#
# Cookbook Name:: strongswan
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "strongswan"

template "/etc/ipsec.conf" do
    source "ipsec.conf.erb"
    ownwer "root"
    group "root"
    mode 0644
    variables({
            :interfaces => node[cookbook_name]['interfaces'],
            :connections => node[cookbook_name]['connections']
        })

    action :create
end

service "ipsec" do
    action [:enable, :restart]
end
