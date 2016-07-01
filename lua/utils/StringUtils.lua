--[[字符串处理--]]
local StringUtils = {};

--[[字符串分割函数 传入字符串和分隔符，返回分割后的table--]]
function StringUtils:split(str,delimiter)
	if str==nil or str=='' or delimiter==nil then
		return nil;
	end
	local result = {};
	for match in (str..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match);
	end
	return result;
end


return StringUtils;