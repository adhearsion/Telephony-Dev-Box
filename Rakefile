task :package do
  system 'vagrant ssh -c "sudo aptitude clean && cat /dev/zero > zero.fill;sync;sleep 1;sync;rm -f zero.fill"'
  system 'vagrant package'
end
