%w{build-essential openssl libssl-dev libpcap-dev libncurses5-dev}.each { |p| package p }

remote_file '/tmp/sipp-3.3.tar.gz' do
  source "http://sourceforge.net/projects/sipp/files/sipp/3.3/sipp-3.3.tar.gz"
  checksum "8c1d513423f9dabee799e738b737e311"
end

cookbook_file '/tmp/sipp_dyn_pcap.diff' do
  source 'sipp_dyn_pcap.diff'
end

script "compile sipp" do
  interpreter "/bin/bash"
  cwd "/tmp"
  code <<-EOF
  tar -xf sipp-3.3.tar.gz
  cd sipp-3.3
  patch < ../sipp_dyn_pcap.diff
  make pcapplay
  cp sipp /usr/local/bin
EOF
  not_if do
    system 'sipp'
    $?.exitstatus == 99
  end
end