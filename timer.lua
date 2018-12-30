#!/usr/local/bin/lua

local wifiConnectionLoop = tmr.create()
i=0
-- tmr.ALARM_AUTO = automatically repeat the alarm
tmr.interval(wifiConnectionLoop, 5000, tmr.ALARM_SINGLE, function ()
  i=i+1
  print('Timer '.. i);
end)
tmr.start(wifiConnectionLoop)