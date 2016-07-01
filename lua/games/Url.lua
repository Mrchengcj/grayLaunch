--[[
url��ַ���㻺�漯���е�����: ��ת������
�����㣺����������
��ȡ�������ݣ� @url1@url2@url3@
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

