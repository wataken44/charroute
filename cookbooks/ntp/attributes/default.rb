# ntp/attributes/default.rb

cookbook_name = 'ntp'

default[cookbook_name]['panic'] = nil
default[cookbook_name]['broadcast'] = nil
default[cookbook_name]['servers'] = ["ntp.jst.mfeed.ad.jp"]
