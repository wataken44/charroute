
cookbook_name = xl2tpd

default[cookbook_name] = {
    'conf' => {
        'access-control' => true,
        'debug' => {
            'avp' => false,
            'network' => false,
            'state' => false,
            'tunnel' => false
        },
        'servers' => {}
    },
    'options' => {
        'mru' => 1280,
        'mtu' => 1280
    },
    'secrets' => {
        'accounts' => []
    }
}
