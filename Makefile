base_boxes: bundle_install ubuntu_base_box centos_base_box

bundle_install:
	bundle install

ubuntu_base_box:
	bundle exec veewee vbox build tdb-ubuntu1204 --force --nogui --auto
	bundle exec veewee vbox export tdb-ubuntu1204
	bundle exec veewee vbox destroy tdb-ubuntu1204

centos_base_box:
	bundle exec veewee vbox build tdb-centos64 --force --nogui --auto
	bundle exec veewee vbox export tdb-centos64
	bundle exec veewee vbox destroy tdb-centos64
