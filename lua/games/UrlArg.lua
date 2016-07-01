--[[
根据url参数改变策略:
参数 : version=[非0数据，非空数据] 满足测试
	   version=0 or version is nil 满足正式
	_LogUtils:debugInfo("lab route name exec");
	_LogUtils:debugInfo("produce route name exec");
--]]
local UrlArg = {};

function UrlArg:work(obj)
	_LogUtils:debugInfo("urlArg.lua exec");
	local arg_version = ngx.var.arg_version or "";
	_LogUtils:debugInfo("arg_version=" .. (arg_version));
	if(arg_version == "0" or arg_version == "") then
		_LogUtils:debugInfo("produce route name exec");
		return obj.router.produceRouteName;
	else
		_LogUtils:debugInfo("lab route name exec");
		return obj.router.labRouteName;
	end
end

return UrlArg;