name              "mojolingo-misc"
maintainer        "Mojo Lingo LLC"
maintainer_email  "ops@mojolingo.com"
license           "MIT"
description       "Miscellaneous small tasks"
recipe            "mojolingo-misc::no_iptables", "Kill iptables"

%w{ ubuntu centos }.each do |os|
  supports os
end

depends 'rbenv'
depends 'sipp', '~> 1.0'
depends 'wav2rtp', '~> 1.0'
depends 'java', '~> 1.6'
