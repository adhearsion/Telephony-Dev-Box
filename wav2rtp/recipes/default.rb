%w{libsndfile1-dev libgsm1-dev libspeex-dev libpcap-dev}.each { |p| package p }

remote_file '/tmp/wav2rtp-0.9.3.tar.gz' do
  source "http://downloads.sourceforge.net/project/wav2rtp/wav2rtp/0.9.3/wav2rtp-0.9.3.tar.gz"
  checksum "fbc7a41c8e68bc5eb9919e6a7f08d6d3da08c17315fe346b9f93e233baa94348"
end

script "compile wav2rtp" do
  interpreter "/bin/bash"
  cwd "/tmp"
  code <<-EOF
  tar -xf wav2rtp-0.9.3.tar.gz
  cd wav2rtp-0.9.3
  ./configure && make
  make install
EOF
  not_if { `wav2rtp -v`.chomp == "0.9.3" }
end