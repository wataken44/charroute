#
# Cookbook Name:: sshd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "ssh"


template "/etc/ssh/sshd_config" do
    var = node[cookbook_name]
    source "sshd_config.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :port => var['port'],
            :listen_address => var['listen-address'],
            :permit_root_login => var['permit-root-login'],
            :password_authentication => var['password-authentication']
        })
    action :create
end

service "ssh" do
    action [:enable, :restart]
end
