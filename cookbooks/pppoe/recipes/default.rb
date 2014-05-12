#
# Cookbook Name:: pppoe
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "pppoe"

node[cookbook_name]['providers'].each do |name, provider|
    template "/etc/ppp/peers/%s" % name do
        source "dsl-provider.erb"
        owner "root"
        group "dip"
        mode 0640
        variables({
                :interface => provider['interface'],
                :user => provider['user'],
                :mss => provider['mss'],
                :no_ip_default => provider['no-ip-default'],
                :use_peer_dns => provider['use-peer-dns'],
                :default_route => provider['default-route'],
                :mtu => provider['mtu']
            })
        action :create
    end
end

# note
# When another cookbook requires to modify pap-secrets, 
# this template should be moved to independent cookbook.
# But because pap-secrets is required by only pppoe cookbook NOW,
# this file is created at here
template "/etc/ppp/pap-secrets" do
    accounts = []
    node[cookbook_name]['providers'].map{ |name, provider|
        accounts << {
            'user' => provider['user'],
            'server' => provider['server'],
            'password' => provider['password'],
            'acceptable-ip' => provider['acceptable-ip']
        }
    }

    source "pap-secrets.erb"
    owner "root"
    group "root"
    mode 0600
    variables({
            :accounts => accounts
        })
    action :create
end

# a bit rude way... all network restart
service "networking" do
    action :restart
end