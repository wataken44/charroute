#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "ntp"

template "/etc/ntp.conf" do
    source "ntp.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :panic => node[:cookbook_name]['panic'],
            :servers => node[:cookbook_name]['servers'],
            :broadcast => node[:cookbook_name]['broadcast']
        })
    action :create
end

service "ntp" do
    action :restart
end
