
default[:cookbook_name] = (default[:cookbook_name] || {}).update({
        :port => 22,
        :listen_address => nil,
        :permit_root_login => 'no',
        :password_authentication => 'yes'
    })
