#!/bin/bash

if [ "`id -u`" != "0" ]; then
  exec sudo $0 $@
  exit $? # Should not get here...
fi

echo -n "Please wait while we launch Voxeo PRISM"

sudo /opt/voxeo/prism/bin/prism service smanager 
sudo /opt/voxeo/prism/bin/prism service ms
sudo /opt/voxeo/prism/bin/prism service as 

for ((i = 0; i <= 30; i++)); do
  echo -n "."
  #sleep 1
done
echo "done."

if [ ! -f /opt/voxeo/prism/.firstrun ]; then
  echo "Voxeo PRISM has been started.
If this is the first time you have launched PRISM, be sure to visit
the administration console to install your evaluation license.
In your browser visit:

http://localhost:18080/console/

Username: admin
Password: admin

From the main screen that appears, click the \"Update\" button
that appears underneath \"License Ports\".

Once licensed you will be able to begin developing Adhearsion apps on PRISM."

  touch /opt/voxeo/prism/.firstrun
fi
