#!/usr/bin/env lua

local pattern = string.char(0x1b)..'%[[0-9;]-[mK]'
while true do
	local line = io.stdin:read("*l")
	if not line then break end
	io.stdout:write(line:gsub(pattern, '').."\n")
end
