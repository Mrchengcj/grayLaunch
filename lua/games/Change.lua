--[[
ÇÐ»»
--]]
local Change = {};

function Change:work(obj)
	_LogUtils:debugInfo("Change.lua exec");
	--_GobalConfig.router.currRouteName = "@client_test";
	return obj.router.labRouteName;
end

return Change;