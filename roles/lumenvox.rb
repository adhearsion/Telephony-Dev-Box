name 'lumenvox'
description 'Installs Lumenvox TTS and ASR services'
run_list "recipe[lumenvox::core]",
  "recipe[lumenvox::client]",
  "recipe[lumenvox::sre]",
  "recipe[lumenvox::media_server]",
  "recipe[lumenvox::tts]",
  "recipe[telephony-dev-box::no_iptables]"

override_attributes 'lumenvox' => {
  'tts' => {
    'voices' => [
      {"voice" => "Chloe"}
    ]
  },
  'sre' => {
    'language_packs' => [{
      "language" => "BritishEnglish"
    }]
  },
  'client' => {
    'license_servers' => ["208.52.151.220"],
    'default_tts_voice' => "default",
    'default_tts_language' => "en-GB"
  }
}
