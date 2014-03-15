default: fetch_cookbooks boxes

clean: create_work_directory fetch_origin_base_boxes

fetch_packer:
	cd tmp; wget https://dl.bintray.com/mitchellh/packer/0.5.2_linux_amd64.zip; unzip 0.5.2_linux_amd64.zip
	export PATH=$PATH:tmp/packer

ci: clean fetch_packer default

create_work_directory:
	rm -r tmp
	mkdir -p tmp

fetch_origin_base_boxes:
	mkdir tmp/ubuntu
	cd tmp/ubuntu; wget http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box; tar -xf opscode_ubuntu-12.04_chef-provisionerless.box

	mkdir tmp/centos
	cd tmp/centos; wget http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box; tar -xf opscode_centos-6.5_chef-provisionerless.box

fetch_cookbooks:
	berks install -p cookbooks

boxes:
	packer build boxes/tdb-adhearsion.json
	packer build boxes/tdb-asterisk.json
	packer build boxes/tdb-freeswitch.json
	packer build boxes/tdb-loadtest.json
	packer build boxes/tdb-lumenvox.json
