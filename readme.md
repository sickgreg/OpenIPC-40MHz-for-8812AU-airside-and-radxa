***40MHz channels for 8812AU cards***

If anyone wants to try 40MHz channels they can replace their /usr/bin/wifibroadcast script on their openIPC camera with this one, which will set the adapter to 40MHz upon loading the driver.  It's a bit of a hack.  Just restore the file to go back.

Also update /etc/wfb.conf to bandwidth=40

(I have only tried channel 161)

On ground station, 40MHz also needs to be set by unloading and reloading the wifi adapter driver.  I've created a shell script that does that.  ```./set40auto.sh 20```
