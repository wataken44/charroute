#
# Cookbook Name:: ppp-secrets
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

['chap', 'pap'].each do |method|
    target_file = "/etc/ppp/%s-secrets" % method

    template target_file do
        source "secrets.erb"
        owner "root"
        group "root"
        mode 0600

        variables({
                :accounts => node[cookbook_name][method]
            })
        action :create
    end
end
