cookbook_name = 'pppoe-server'

default[cookbook_name] = {
    'interfaces' => [],
    'local-ip' => '',
    'remote-ip' => '',
    'server-options' => {
        'require-chap' => false,
        'require-pap' => true
    }
}
