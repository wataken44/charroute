
cookbook_name = "unbound"

default[cookbook_name] = {
    'interfaces' => [],
    'access-control' => {
        'allow' => [],
        'deny' => []
    },
    'unwanted-reply-threshold' => 10 * 1000 * 1000
}

