task default: [:fetch, :boot]

RAYO_BUILD = 189

task :fetch do
  component_dir = File.join(File.expand_path(File.dirname(__FILE__)), 'components_to_be_installed')

  require_relative 'scripts/rayo_fetcher.rb'

  puts "Adding lucid32 vagrant box..."
  `vagrant box add lucid32 http://files.vagrantup.com/lucid32.box`

  puts "Downloading PRISM..."
  `curl -C - -L -o #{File.join(component_dir, 'prism')}/prism.bin http://www.voxeo.com/prism/prism11_download_linux.jsp`

  puts "Downloading rayo-server..."
  RayoFetcher.download to: File.join(component_dir, 'rayo')
end

task :boot do
  puts "Booting the system..."
  system 'vagrant up'
end

task :package do
  system 'vagrant ssh -c "sudo aptitude clean && cat /dev/zero > zero.fill;sync;sleep 1;sync;rm -f zero.fill"'
  system 'vagrant package --vagrantfile Vagrantfile.pkg'
end
