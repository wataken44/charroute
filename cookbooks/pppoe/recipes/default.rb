#
# Cookbook Name:: pppoe
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ppp-secrets::default"

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

# a bit rude way... all network restart
service "networking" do
    action :restart
end
