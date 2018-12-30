--functions.lua
-- b.nelissen
-- winter 2018/2019

-- print filename
print("functions.lua")

-- check if file is readable, return true or false
function file_exists(name)
	if file.open(name,"r")
		file.close()
		return true
	else
	return false
	end
end
