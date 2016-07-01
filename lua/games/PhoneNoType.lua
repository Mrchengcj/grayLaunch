--[[
根据手机号段引流
   cache: @159@138@134@
--]]

local PhoneNoType = {};

function PhoneNoType:work(obj)
	_LogUtils:debugInfo("phoneNoType.lua work exec");
	--_LogUtils:debugInfo(_phoneNoTypes);
	_LogUtils:debugInfo("==================userInfo value begin========================");
	_LogUtils:debugInfo("phoneNo=" .. (obj.userInfo.phoneNo or ""));
	_LogUtils:debugInfo("userType=" .. (obj.userInfo.userType or ""));
	_LogUtils:debugInfo("brandType=" .. (obj.userInfo.brandType or ""));
	_LogUtils:debugInfo("phoneNoType=" .. (obj.userInfo.phoneNoType or ""));
	_LogUtils:debugInfo("area=" .. (obj.userInfo.area or ""));
	_LogUtils:debugInfo("==================userInfo value end========================");
		if(obj.gamesParam.phoneNoType ~= nil) then
			if (ngx.re.match(ngx.escape_uri(obj.gamesParam.phoneNoType),ngx.escape_uri(obj.splitChar .. obj.userInfo.phoneNoType .. obj.splitChar))) then
				_LogUtils:debugInfo("lab route name exec");
				return obj.router.labRouteName;
			else
				_LogUtils:debugInfo("produce route name exec");
				return obj.router.produceRouteName;
			end
		else
			_LogUtils:debugInfo("produce route name exec");
			return obj.router.produceRouteName;
		end
end

return PhoneNoType;