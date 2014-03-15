default: create_work_directory fetch_packer fetch_origin_base_boxes build_tdb_boxes

create_work_directory:
	rm -r tmp
	mkdir -p tmp

fetch_packer:
	cd tmp; wget https://dl.bintray.com/mitchellh/packer/0.5.2_linux_amd64.zip; unzip 0.5.2_linux_amd64.zip

fetch_origin_base_boxes:
	mkdir tmp/ubuntu
	cd tmp/ubuntu; wget http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-12.04_chef-provisionerless.box; tar -xf opscode_ubuntu-12.04_chef-provisionerless.box

	mkdir tmp/centos
	cd tmp/centos; wget http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.5_chef-provisionerless.box; tar -xf opscode_centos-6.5_chef-provisionerless.box

fetch_cookbooks:
	berks install -p cookbooks

build_tdb_boxes:
	tmp/packer build boxes/tdb-adhearsion.json
	tmp/packer build boxes/tdb-asterisk.json
	tmp/packer build boxes/tdb-freeswitch.json
	tmp/packer build boxes/tdb-loadtest.json
	tmp/packer build boxes/tdb-lumenvox.json
