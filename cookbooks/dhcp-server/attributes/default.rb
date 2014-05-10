
cookbook_name = "dhcp-server"

default[cookbook_name]['init'] = {
    'options' => nil,
    'interfaces' => []
}
default[cookbook_name]['conf'] = {
    'subnets' => []
}
