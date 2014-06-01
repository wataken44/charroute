
cookbook_name = 'strongswan'

default[cookbook_name]['conf'] = {
    'interfaces' => nil,
    'connections' => {}
}

default[cookbook_name]['secrets'] = {
    'secrets' => []
}
