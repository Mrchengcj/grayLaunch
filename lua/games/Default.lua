--[[
Ĭ��ִ����
_GobalConfig.router.labRouteName; --����/���Ի���
_GobalConfig.router.produceRouteName; --����/��ʽ����
--]]
local Default = {};
function Default:work(obj)
	_LogUtils:debugInfo("default.lua exec");
	_LogUtils:debugInfo("produce route name exec");
	return obj.router.produceRouteName;
end
return Default;


