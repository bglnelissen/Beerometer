--wifimanager.lua
-- b.nelissen
-- winter 2018/2019

-- print filename
print("credentials.lua")

-- check if file credentials.lua exists on device
if file_exists("credentials.lua") then
	dofile('credentials.lua')
	
	-- The WiFi mode, as one of the wifi.STATION, wifi.SOFTAP, wifi.STATIONAP or wifi.NULLMODE constants.
  -- Station mode is the mode were the ESP connects to wifi and act as a client.  
	wifi.setmode(wifi.STATION)
	print("ESP8266 mode now is: " .. wifi.getmode())

	-- configure the module so it can connect to the network using the received SSID and password
	config_wifi={}
	config_wifi.ssid=SSID
	config_wifi.pwd=PASS
	wifi.sta.config(config_wifi)
	wifi.sta.connect()
 
  -- give MAC address back as feedback
  print('MAC address: ' .. wifi.sta.getmac())

  -- loop with 1 second delay
  

	-- Finite loop to check if wifi is connected
	tmr.alarm(2,5000,1,function()
  print("Uptime:", tmr.time())
		print('Timer loop...')
		-- Connect wifi
		if wifi.sta.getip() == nil then
			print('IP unavaiable, waiting...')
		else
			tmr.stop(2)          
			print('IP: '..wifi.sta.getip())
      print("hostname: ".. wifi.sta.gethostname())
		end
	end)
else
	print('Error, file does not exists:\n- credentials.lua')
end
