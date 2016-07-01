--[[
url地址满足缓存集合中的数据: 跳转到测试
不满足：调整到测试
读取缓存数据： @url1@url2@url3@
_LogUtils:debugInfo("lab route name exec");
_LogUtils:debugInfo("produce route name exec");
--]]

local Url = {};

function Url:work(obj)
	_LogUtils:debugInfo("url.lua is exec");
	--local uri_full = (string.gsub((ngx.var.request_uri or ""),"?.*$",""));
	local uri_full = (ngx.var.uri or "");
	_LogUtils:debugInfo("request uri_full=[" .. uri_full.."]");
	_LogUtils:debugInfo("obj.gamesParam.urls=[" .. (obj.gamesParam.urls or ""));
	if ngx.re.match(ngx.escape_uri(obj.gamesParam.urls ),ngx.escape_uri(obj.splitChar .. uri_full .. obj.splitChar)) then
		_LogUtils:debugInfo("lab route name exec");
		return obj.router.labRouteName;
	else
		_LogUtils:debugInfo("produce route name exec");
		return obj.router.produceRouteName;
	end
end

return Url;

