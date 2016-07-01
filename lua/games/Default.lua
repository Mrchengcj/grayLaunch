--[[
默认执行器
_GobalConfig.router.labRouteName; --试验/测试环境
_GobalConfig.router.produceRouteName; --生产/正式环境
--]]
local Default = {};
function Default:work(obj)
	_LogUtils:debugInfo("default.lua exec");
	_LogUtils:debugInfo("produce route name exec");
	return obj.router.produceRouteName;
end
return Default;


