--[[
用户信息获取，用uSign做key，value值为：加密后手机号码@用户类型@品牌名称@手机号段@归属区域 
ccccc@1@1@159@1
--]]

local UserInfo = {};
function UserInfo:getUserInfo()
	
	--local uSign =  ngx.unescape_uri(ngx.var.cookie_uSign or "");
	local uSign = (string.gsub(ngx.unescape_uri(ngx.var.cookie_uSign or ""),"\"",""));
  --local uSign = (string.gsub((string.gsub(ngx.unescape_uri(ngx.var.cookie_uSign or ""),"\"","")),"%40",_GobalConfig.splitChar));
	_LogUtils:debugInfo("uSign= " .. uSign);
	local userInfo = {};
	local userData = _StringUtils:split(uSign,_GobalConfig.splitChar);
	if(userData ~= nil and table.getn(userData) == 5) then
		userInfo = {phoneNo = userData[1],userType = userData[2],brandType = userData[3],phoneNoType = userData[4],area = userData[5]};
	else
		_LogUtils:debugInfo("userData is nil or userData length < 5");
		userInfo = {phoneNo = "",userType = "",brandType = "",phoneNoType = "",area = ""};
	end
	return userInfo;
end


return UserInfo;