-- b.nelissen
-- 2018 dec
-- https://nodemcu.readthedocs.io/en/master/en/modules/gpio/

-- GPIO Pin layout
-- 0* GPIO16        7  GPIO13
-- 1  GPIO5         8  GPIO15
-- 2  GPIO4         9  GPIO3
-- 3  GPIO0        10  GPIO1
-- 4  GPIO2        11  GPIO9
-- 5  GPIO14       12  GPIO10
-- 6  GPIO12
-- [*] D0(GPIO16) can only be used as gpio read/write. No support for open-drain/interrupt/pwm/i2c/ow.

-- Set GPIO2 (pin 4) to high
local pin = 4 --> GPIO2
local value = gpio.HIGH
gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, value)

-- Init GPIO13 (pin 7) to listen to button the event
local button_pin = 7
gpio.mode(button_pin, gpio.INT, gpio.PULLUP) -- memo, moet dit niet pulldown zijn?

-- Function toggles LED state
function toggleLED ()
  if value == gpio.LOW
  then
    value = gpio.HIGH
  else
    value = gpio.LOW
  end
  gpio.write(pin, value)
end

-- define a callback function
function pin_callback()
  print("Reset config button pressed.")
  toggleLED()
  
  print("Removing credentials file and rebooting the device.") -- Reset means reset ;)
  file.remove("credentials.lua")
  
  print("Restart...")
  node.restart()
end

-- register a button event
-- > what's registered here is executed upon button event "up"
gpio.trig(button_pin, "up", pin_callback)