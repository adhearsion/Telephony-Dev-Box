asterisk Mash.new unless attribute?(:asterisk)

#Setup the Manager.conf file, refer to: http://www.voip-info.org/tiki-index.php?page=Asterisk%20config%20manager.conf
#[general]
asterisk[:manager_enabled]         = 'yes'
asterisk[:manager_port]            = 5038
asterisk[:manager_ip_address]      = '127.0.0.1'
asterisk[:manager_webenabled]      = 'yes'
asterisk[:manager_timestampevents] = 'yes'

#[user] section
asterisk[:manager_username]    = 'manager'
asterisk[:manager_password]    = 'password'
asterisk[:manager_deny]        = '0.0.0.0/0.0.0.0'
asterisk[:manager_permit]      = '127.0.0.1/255.255.255.0'
asterisk[:manager_read_perms]  = %w(system call log verbose command agent user config)
asterisk[:manager_write_perms] = %w(system call log verbose command agent user config)

#Setup the SIP.conf file, refer to: http://www.voip-info.org/wiki/view/Asterisk+config+sip.conf
asterisk[:sip_conf_context]              = 'default'
asterisk[:sip_conf_allowguest]           = 'yes'
asterisk[:sip_confallowoverlap]          = 'no'
asterisk[:sip_conf_allowtransfer]        = 'no'
asterisk[:sip_conf_realm]                = 'mydomain.com'
asterisk[:sip_conf_domain]               = 'mydomain.com'
asterisk[:sip_conf_bindport]             = 5060
asterisk[:sip_conf_bindaddr]             = '0.0.0.0'
asterisk[:sip_conf_tcpenable]            = 'yes'
asterisk[:sip_conf_srvlookup]            = 'yes'
asterisk[:sip_conf_pedantic]             = 'yes'
asterisk[:sip_conf_tos_sip]              = 'cs3'
asterisk[:sip_conf_tos_audio]            = 'ef'
asterisk[:sip_conf_tos_video]            = 'af41'
asterisk[:sip_conf_maxexpiry]            = '3600'
asterisk[:sip_conf_minexpiry]            = 60
asterisk[:sip_conf_defaultexpiry]        = 120
asterisk[:sip_conf_t1min]                = 100
asterisk[:sip_conf_notifymimetype]       = 'text/plain'
asterisk[:sip_conf_checkmwi]             = 10
asterisk[:sip_conf_buggymwi]             = 'no'
asterisk[:sip_conf_vmexten]              = 'voicemail'
asterisk[:sip_conf_disallow]             = 'all'
asterisk[:sip_conf_allow]                = %w(ulaw gsm ilbc speex)
asterisk[:sip_conf_mohinterpret]         = 'default'
asterisk[:sip_conf_mohsuggest]           = 'default'
asterisk[:sip_conf_language]             = 'en'
asterisk[:sip_conf_relaxdtmf]            = 'yes'
asterisk[:sip_conf_trustrpid]            = 'no'
asterisk[:sip_conf_sendrpid]             = 'yes'
asterisk[:sip_conf_progressinband]       = 'never'
asterisk[:sip_conf_useragent]            = 'Asterisk with Adhearsion'
asterisk[:sip_conf_promiscredir]         = 'no'
asterisk[:sip_conf_usereqphone]          = 'no'
asterisk[:sip_conf_dtmfmode]             = 'rfc2833'
asterisk[:sip_conf_compactheaders]       = 'yes'
asterisk[:sip_conf_videosupport]         = 'yes'
asterisk[:sip_conf_maxcallbitrate]       = 384
asterisk[:sip_conf_callevents]           = 'no'
asterisk[:sip_conf_alwaysauthreject]     = 'yes'
asterisk[:sip_conf_g726nonstandard]      = 'yes'
asterisk[:sip_conf_matchexterniplocally] = 'yes'
asterisk[:sip_conf_regcontext]           = 'sipregistrations'
asterisk[:sip_conf_rtptimeout]           = 60
asterisk[:sip_conf_rtpholdtimeout]       = 300
asterisk[:sip_conf_rtpkeepalive]         = 60
asterisk[:sip_conf_sipdebug]             = 'yes'
asterisk[:sip_conf_recordhistory]        = 'yes'
asterisk[:sip_conf_dumphistory]          = 'yes'
asterisk[:sip_conf_allowsubscribe]       = 'no'
asterisk[:sip_conf_subscribecontext]     = 'default'
asterisk[:sip_conf_notifyringing]        = 'yes'
asterisk[:sip_conf_notifyhold]           = 'yes'
asterisk[:sip_conf_limitonpeers]         = 'yes'
asterisk[:sip_conf_t38pt_udptl]          = 'yes'

#Setup our SIP Providers
asterisk[:sip_providers] = Mash.new
asterisk[:sip_providers][:flowroute] = Mash.new(:type => 'friend', :host => 'sip.flowroute.com', :dtmf_mode => 'rfc2833', :context => 'flowroute', :canreinvite => 'no', :allowed_codecs => ['ulaw', 'g729'], :insecure => 'port,invite', :qualify => 'yes')

# uncomment the following to set an explicit public IP for SIP behind NAT. Default is the current host's ip address (or ec2 public IP if on ec2)
# asterisk[:public_ip] = '1.2.3.4'
