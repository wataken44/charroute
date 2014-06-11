
cookbook_name = "isc-dhcp-server"

default[cookbook_name]['init'] = {
    'options' => nil,
    'interfaces' => []
}
default[cookbook_name]['conf'] = {
    'shared-networks' => {}
}
