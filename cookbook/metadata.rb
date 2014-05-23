name              "telephony-dev-box"
maintainer        "Mojo Lingo LLC"
maintainer_email  "ops@mojolingo.com"
license           "MIT"
description       "Miscellaneous build stuff for Telephony Dev Box"
recipe            "telephony-dev-box::no_iptables", "Kill iptables"

%w{ ubuntu centos }.each do |os|
  supports os
end

depends 'rbenv'
depends 'sipp', '~> 1.0'
depends 'wav2rtp', '~> 1.0'
depends 'java', '~> 1.6'
