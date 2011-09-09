Description
===========

Installs Asterisk 1.8 on Debian/Ubuntu and configures it to accept incoming and
outgoing calls for a single Google Voice number.

Changes
=======

## v0.4.0:

* Add documentation and a check to make sure we're in Ubuntu/Debian

## v0.3.0:

* Initial version, tested on Ubuntu only

Requirements
============

## Platform:

* Ubuntu and Debian, 64 bit (amd64/x86\_64)

Other platforms can be used but you'll need to modify the default recipe.

Attributes
==========

There are a number of attributes defined in the cookbook, but the defaults are
pretty sane. You probably don't need to change any of them to get a working
setup.

However, you'll need to configure two data bags. The `asterisk` data bag should
contain your desired Asterisk accounts (I've only tested it with one) defined
like this:

    id:         <your desired username>
    data_bag:   asterisk
    extension:  <the extension # for your PBX line, I just use 101>
    full_name:  <full display name>
    password:   <your desired password>
    username:   <your desired username>

Your Google account should be configured in a more general `auth` data bag. I
keep this separate from the Asterisk config because it's also used by other
cookbooks in my system. My `auth` data bag is where I keep credentials info for
all third-party accounts. The `auth` data bag must contian a `google` object
like this:

    id:        google
    username:  <your Google username>@gmail.com
    password:  <your Google password>

Usage
=====

Include the asterisk default recipe in a role run list.

    name "role_for_asterisk"
    run_list("recipe[asterisk]")

Once Asterisk is installed, you should be able to open any SIP client (like
Ekiga in Ubuntu) and connect to it using the account you set up in the
`asterisk` data bag.

License and Author
==================

* Copyright 2011, Christopher Peplin <chris.peplin@rhubarbtech.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
