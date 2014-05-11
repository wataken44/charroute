#
# Cookbook Name:: pppoe-server
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

Log.logger.warn "recipe[pppoe-server] is only for testing."
Log.logger.warn "only /etc/ppp/pppoe-server-options will be created."

package "pppoe"

template "/etc/ppp/pppoe-server-options" do
    source "pppoe-server-options.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
            :interfaces => node[cookbook_name]['interfaces'],
            :local_ip => node[cookbook_name]['local-ip'],
            :remote_ip => node[cookbook_name]['remote-ip'],
            :require_chap => node[cookbook_name]['server-options']['require-chap'],
            :require_pap => node[cookbook_name]['server-options']['require-pap']
        })
    action :create
end
