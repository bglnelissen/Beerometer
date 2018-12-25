-- b.nelissen
-- 2018 dec

-- print filename
print("wifimanager.lua")

-- check if file credentials.lua exists on device
if file.open("credentials.lua") then
  print(file.read())
  file.close()
  dofile("credentials.lua")
  -- file exists, running on station mode
  dofile("station_mode.lua")
-- elseif file.open("ap_mode.lua") then
--   -- file don't exists, runnning on ap mode
--   print("Credentials file not found, going into AP mode")
--   dofile("ap_mode.lua")
else
  print("Error, files not found:")
  print("- credentials.lua")
  print("- ap_mode.lua")
end

