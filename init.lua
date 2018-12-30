--init.lua
-- b.nelissen
-- winter 2018/2019

-- This file makes sure it all boots and is verbose on its actions for debugging.

-- functions
dofile('functions.lua')

-- reset button
if file_exists('reset.lua') then
	dofile('reset.lua')
else
	print('Error, file does not exists:\n- reset.lua')
end

-- wifi
if file_exists('wifimanager.lua') then
	dofile('wifimanager.lua')
else
	print('Error, file does not exists:\n- wifimanager.lua')
end
