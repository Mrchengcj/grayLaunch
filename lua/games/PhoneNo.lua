--[[
根据手机号码引流
--]]
local PhoneNo = {};
function PhoneNo:work(obj)
	_LogUtils:debugInfo("phoneNo.lua exec");
	_LogUtils:debugInfo("_phoneNo="..(obj.gamesParam.phoneNo or ""));
	if(obj.gamesParam.phoneNo ~= nil and obj.gamesParam.phoneNo == "1") then
		_LogUtils:debugInfo("lab route name exec");
		return obj.router.labRouteName;
	else
		_LogUtils:debugInfo("produce route name exec");
		return obj.router.produceRouteName;
	end
end

return PhoneNo;