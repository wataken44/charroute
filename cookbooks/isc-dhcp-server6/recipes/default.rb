#
# Cookbook Name:: isc-dhcp-server6
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "isc-dhcp-server"

workdir = Chef::Config[:file_cache_path] + '/debian-isc-dhcp-server6'

enabled = node[cookbook_name]["enable"]

git workdir do
    repository "https://github.com/wataken44/debian-isc-dhcp-server-v6.git"
    action :sync
    notifies :run, 'bash[install.sh]'
end

bash 'install.sh' do
    action :nothing
    code "sh %s/scripts/install.sh" % workdir

    notifies :create, 'template[/etc/default/isc-dhcp-server6]'
    notifies :create, 'template[/etc/dhcp/dhcpd6.conf]'
end

template "/etc/default/isc-dhcp-server6" do
    source "isc-dhcp-server6.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :interfaces => node[cookbook_name]['init']['interfaces'],
            :options => node[cookbook_name]['init']['options']
        })
    action :create
end

template "/etc/dhcp/dhcpd6.conf" do
    source "dhcpd6.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :shared_networks => node[cookbook_name]['conf']['shared-networks']
        })
    action :create
end

if enabled then
    service "isc-dhcp-server6" do
        action [:enable, :restart]
    end
else
    service "isc-dhcp-server6" do
        action [:disable, :stop]
    end
end
