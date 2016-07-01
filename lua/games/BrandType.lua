--[[
根据手机品牌类型引流
   cache: @神州行@动感地带@ 或 @1@2@
--]]
local BrandType = {};
function BrandType:work(obj)
	_LogUtils:debugInfo("brandType.lua exec");
	_LogUtils:debugInfo("obj.userInfo.brandType=" ..(obj.userInfo.brandType or ""));
	if(obj.gamesParam.brandType ~= nil) then
		if (ngx.re.match(ngx.escape_uri(obj.gamesParam.brandType),ngx.escape_uri(obj.splitChar .. obj.userInfo.brandType .. obj.splitChar))) then
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

return BrandType;