
cookbook_name = "isc-dhcp-server6"

default[cookbook_name] = {
    'enable' => false,
    'init' => {
        'options' => nil,
        'interfaces' => []
    },
    'conf' => {
        'shared-networks' => {}
    }
}
