#
# Cookbook Name:: dhcp-server
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "isc-dhcp-server"

template "/etc/default/isc-dhcp-server" do
    source "isc-dhcp-server.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :interfaces => node[cookbook_name]['init']['interfaces'],
            :options => node[cookbook_name]['init']['options']
        })
    action :create
end

template "/etc/dhcp/dhcpd.conf" do
    source "dhcpd.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :shared_networks => node[cookbook_name]['conf']['shared-networks']
        })
    action :create
end

service "isc-dhcp-server" do
    action [:enable, :restart]
end
