#
# Cookbook Name:: xl2tpd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "xl2tpd"

conf = node[cookbook_name]['conf']
secrets = node[cookbook_name]['secrets']
options = node[cookbook_name]['options']

template "/etc/xl2tpd/xl2tpd.conf" do
    source "xl2tpd.conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :port => conf['port'],
            :debug => conf['debug'],
            :access_control => conf['access-control'],
            :servers => conf['servers']
        })

    action :create
end

template "/etc/xl2tpd/l2tp-secrets" do
    source "l2tp-secrets.erb"
    owner "root"
    group "root"
    mode 0600
    variables({
            :accounts => secrets['accounts']
        })

    action :create
end

template "/etc/ppp/options.xl2tpd" do
    source "options.xl2tpd.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :crtscts => options['crtscts'],
            :debug => options['debug'],
            :ipcp_accept_local => options['ipcp-accept-local'],
            :ipcp_accept_remote => options['ipcp-accept-remote'],
            :lock => options['lock'],
            :mru => options['mru'],
            :ms_dns => options['ms-dns'],
            :mtu => options['mtu'],
            :noccp => options['noccp'],
            :proxyarp => options['proxyarp'],
        })
  
    action :create
end

service "xl2tpd" do
    action [:enable, :restart]
end
