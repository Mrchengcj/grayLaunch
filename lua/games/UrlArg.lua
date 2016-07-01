--[[
����url�����ı����:
���� : version=[��0���ݣ��ǿ�����] �������
	   version=0 or version is nil ������ʽ
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