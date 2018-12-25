# Beerometer

## Goal

Create WiFi, invisible or not, with the name '🍺🌡 5℃'

## ToDo

- Prepare the ESP
- Get the temperature
- Create Wifi
- Update the Wifi SSID with the current temperature
- Make wifi invisible
- Add unique variables to the wifi with unicode
- Create QR-code that matches the beginning the unique part of the wifi name

## Setup

To simplefy the process we use the RaspberryPi to connect to the ESP dev board. This will prevent  issues between the serial USB controller and MacOS and will make it possible to make it easier to develop on different machines. Development largely happens on the RaspberryPi. We use `ssh` to login on the RaspberryPi and do the development there. Schematically this is how we develop:

```
Mac --> RaspberryPi --> ESP
```

Prepare the pi and install `esptool.py` via the python package manager.

```
pip install esptool
/usr/local/bin/esptool.py --help
```

NodeMCU uploader

```
pip install nodemcu-uploader
nodemcu-uploader -h
```


## Steps

### Prepare the ESP

Create binairy on the [NodeMCU build](https://nodemcu-build.com) site. Use the master branche, select the following modules:

  - Cron
  - DHT
  - DS18B20
  - end user setup
  - file
  - GPIO
  - I2C
  - MQTT
  - net
  - node
  - 1-Wire
  - timer
  - UART
  - WiFi

```
You successfully commissioned a NodeMCU custom build from the master branch. You selected the following 14 modules: cron dht ds18b20 enduser_setup file gpio i2c mqtt net node ow tmr uart wifi.
```

Download your build. Use the floating point build. The floating point variant handles non-integer values properly and this greatly simplifies numeric calculations. The RAM difference is minimal.

Backup flash

```
# on the pi
cd ~/Beerometer
mkdir -p ./backup
sudo /usr/local/bin/esptool.py -p /dev/ttyUSB0 -b 460800 read_flash 0 0x200000 ./backup/flash_contents."$(date +%Y%m%d%H%M)".bin
```

Erase flash

```
sudo /usr/local/bin/esptool.py -p /dev/ttyUSB0 erase_flash
```

Write flash

```
# see esptool.py write_flash -h
sudo /usr/local/bin/esptool.py --port /dev/ttyUSB0 write_flash --flash_mode qio  0x00000 flash.bin

```
### NodeMCU-Tool installation

The list of features is quite long but essentially NodeMCU-Tool offers:

- upload (Lua) files from your host system to the device
- manage the device file system (delete, up-/download, etc.)
- run files on NodeMCU and display the output over UART/serial

Install `nodemcu-tool`

Install Node.js and NPM if not available yet

- # node -v, npm -v
- `cd ~/`
- `sudo apt-get -y update && sudo apt-get -y dist-upgrade && sudo reboot`
- `curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -`
- `sudo apt-get install -y gcc g++ make nodejs`

Install NodeMCU-Tool globally: `sudo npm install --unsafe-perm nodemcu-tool -g`
Verify installation by runnin `nodemcu-tool --version`

### NodeMCU-Tool usage

How it works

```
sudo nodemcu-tool -h
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
