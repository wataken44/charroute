#
# Cookbook Name:: wide-dhcpv6-client
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "wide-dhcpv6-client"

template "/etc/wide-dhcpv6/dhcp6c.conf" do
    source "dhcp6c.conf.erb"
    owner "root"
    group "root"
    mode 0644

    variables({
            :interfaces => node[cookbook_name]['conf']['interfaces'],
            :identity_associations => node[cookbook_name]['conf']['identity-associations'],
        })
    action :create
end

template "/etc/default/wide-dhcpv6-client" do
    source "wide-dhcpv6-client.erb"
    owner "root"
    group "root"
    mode 0644

    variables({
            :interfaces => node[cookbook_name]['init']['interfaces']
        })
    action :create    
end

service "wide-dhcpv6-client" do
    if node[cookbook_name]["enable"] then
        action [:enable, :restart]
    else
        action [:disable, :stop]
    end
end
