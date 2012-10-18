maintainer        "Mojo Lingo LLC"
maintainer_email  "ops@mojolingo.com"
license           "MIT"
description       "Miscellaneous small tasks"
recipe            "mojolingo-misc::no_iptables", "Kill iptables"

%w{ ubuntu centos }.each do |os|
  supports os
end
