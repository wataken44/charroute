#
# Cookbook Name:: unbound
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "unbound"

template "/etc/unbound/unbound.conf" do
    source "unbound.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :interfaces => node[cookbook_name]['interfaces'],
            :access_control => node[cookbook_name]['access-control'],
            :unwanted_reply_threshold => node[cookbook_name]['unwanted-reply-threshold'],
        })
    action :create
end

service "unbound" do
    action :restart
end
