--[[
ip执行器
_GobalConfig.router.labRouteName; --试验/测试环境
_GobalConfig.router.produceRouteName; --生产/正式环境
set labIP@127.0.0.1
--_GobalConfig.router.currRouteName = "@client_test";
--]]

local Ip = {};
function Ip:work(obj)
	_LogUtils:debugInfo("ip.lua exec");
	_LogUtils:debugInfo("ip=" ..(obj.gamesParam.ip or ""));
	if(obj.gamesParam.ip ~= nil and obj.gamesParam.ip == "1") then --测试
		_LogUtils:debugInfo("lab route name exec");
		return obj.router.labRouteName;
	else
		_LogUtils:debugInfo("produce route name exec");
		return obj.router.produceRouteName;
	end
end

return Ip;
