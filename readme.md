***40MHz channels for 8812AU cards***

If anyone wants to try 40MHz channels they can replace their `/usr/bin/wifibroadcast` script on their openIPC camera with this one (rename it to `wifibroadcast` after copying it to cam. I named it that way so i know what it is), which will set the adapter to 40MHz upon loading the driver.  It's a bit of a hack.  Just restore the old file to go back.

Also change `/etc/wfb.conf` to include bandwidth=40

(btw, I have only tried channel 161, hence the hardcoded ch 161 in the following script. Feel free to change it in the script if you want)

On ground station, 40MHz also needs to be set by unloading and reloading the wifi adapter driver.  I've created a shell script that does that.  ```./set40auto.sh 20``` to reload the driver with power level 20 (say, for alink) and iterate through the wifi cards (that it finds in /etc/default/wifibroadcast), setting them all to channel 161 @ 40MHz.  Download the script to your ground station, in my case to `/home/radxa` directory and make it executable
