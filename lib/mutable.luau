
local None = require(script.Parent.immutable).None

local function merge(base, extension)
	for key, value in extension do
		if value == None then
			base[key] = nil
		else
			base[key] = value
		end
	end

	return base
end

-- https://github.com/cxmeel/sift/blob/main/src/Dictionary/copyDeep.lua
local function copyDeep(dictionary)
	local new = table.clone(dictionary)

	for key, value in pairs(dictionary) do
		if type(value) == "table" then
			new[key] = copyDeep(value)
		end
	end

	return new
end

-- https://github.com/cxmeel/sift/blob/main/src/Dictionary/equalsDeep.lua
local function equalsDeep(a, b)
	if type(a) ~= "table" or type(b) ~= "table" then
		return a == b
	end

	for key, value in pairs(a) do
		if not equalsDeep(value, b[key]) then
			return false
		end
	end

	for key, value in pairs(b) do
		if not equalsDeep(value, a[key]) then
			return false
		end
	end

	return true
end

return {
	None = None,
	merge = merge,
    copyDeep = copyDeep,
    equalsDeep = equalsDeep,
}
