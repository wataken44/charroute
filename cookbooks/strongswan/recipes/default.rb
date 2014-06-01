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
    owner "root"
    group "root"
    mode 0644
    variables({
            :interfaces => node[cookbook_name]['conf']['interfaces'],
            :connections => node[cookbook_name]['conf']['connections']
        })

    action :create
end

template "/etc/ipsec.secrets" do
    source "ipsec.secrets.erb"
    owner "root"
    group "root"
    mode 0600 
    variables({
            :secrets => node[cookbook_name]['secrets']['secrets']
        })
    action :create
end


service "ipsec" do
    action [:enable, :restart]
end
