--[[
根据用户类型(活跃用户、种子用户、普通用户)引流
   cache: @活跃用户@普通用户@ 或 @1@2@
--]]

local UserType = {};

function UserType:work(obj)
	_LogUtils:debugInfo("userType.lua exec");
	_LogUtils:debugInfo("obj.userInfo.userType=" .. (obj.userInfo.userType or ""));
	_LogUtils:debugInfo("obj.gamesParam.userType=" .. (obj.gamesParam.userType or ""));

	
	if(obj.gamesParam.userType ~= nil) then
		if (ngx.re.match(ngx.escape_uri(obj.gamesParam.userType),ngx.escape_uri(obj.splitChar .. obj.userInfo.userType .. obj.splitChar))) then
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

return UserType;
