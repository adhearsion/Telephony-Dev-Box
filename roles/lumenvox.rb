name 'lumenvox'
description 'Installs Lumenvox TTS and ASR services'
run_list "recipe[lumenvox::core]",
  "recipe[lumenvox::client]",
  "recipe[lumenvox::sre]",
  "recipe[lumenvox::media_server]",
  "recipe[lumenvox::tts]",
  "recipe[mojolingo-misc::no_iptables]"

override_attributes 'lumenvox' => {
  'core' => {
    'version' => '11.3.100-2.el6'
  },
  'tts' => {
    'version' => '11.3.100-1SF.el6',
    'voices' => [
        {
          "voice" => "Ben",
          "version" => "11.3.100-1"
        },
        {
          "voice" => "Chloe",
          "version" => "11.3.100-1"
        },
        {
          "voice" => "Chris",
          "version" => "11.3.100-1"
        },
        {
          "voice" => "Lindsey",
          "version" => "11.3.100-1"
        },
    ]
  },
  'sre' => {
    'version' => '11.3.100-2.el6',
    'language_packs' => [
      {
        "language" => "BritishEnglish",
        "version" => "11.3.100-1"
      },
    ]
  },
  'media_server' => {
    'version' => '11.3.100-2.el6'
  },
  'client' => {
    'version' => '11.3.100-2.el6',
    'license_servers' => ["208.52.151.220"],
    'default_tts_voice' => "default",
    'default_tts_language' => "en-US"
  }
}
