# Beerometer

Private project for getting started with `lua` and learning how to work the the ESP8266.


Backup ESP flash

```
sudo /usr/local/bin/esptool.py -p /dev/ttyUSB0 read_flash 0 0x200000 ./backup/flash_contents."$(date +%Y%m%d%H%M)".bin
```

Write ESP flash

```
sudo /usr/local/bin/esptool.py --port /dev/ttyUSB0 write_flash --flash_mode qio  0x00000 ./binairies/nodemcu-master-14-modules-2018-12-22-08-44-43-float.bin 
```

Create a lua script
```
-- this is the content of the file helloworld.lua
print('Hello World!')
```

Upload a Lua file
```
sudo nodemcu-tool upload --port=/dev/ttyUSB0 helloworld.lua
```

Run it
```
sudo nodemcu-tool run helloworld.lua
```
