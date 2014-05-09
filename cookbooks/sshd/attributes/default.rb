
cookbook_name = 'sshd'
default[cookbook_name] = {
    'port' => 22,
    'listen-address' => nil,
    'permit-root-login' => 'no',
    'password-authentication' => 'yes'
}
