--[[
根据用户手机归属区域分流 （1 成都 2绵阳 3内江 等）
   cache: @1@2@3@4@
--]]
local Area = {};
function Area:work(obj)
	_LogUtils:debugInfo("area.lua exec");
	_LogUtils:debugInfo("obj.userInfo.area=" .. (obj.userInfo.area or ""));
	if(obj.gamesParam.area ~= nil) then
		if (ngx.re.match(ngx.escape_uri(obj.gamesParam.area),ngx.escape_uri(obj.splitChar .. obj.userInfo.area .. obj.splitChar))) then
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
return Area;
