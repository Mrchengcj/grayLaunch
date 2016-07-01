--[[
用于设置分流规则，用于设置memcache 和生成配置文件
--]]
--package.path = "E:\\api\\lua\\demo\\ngx\\?.lua;E:\\api\\lua\\demo\\ngx\\games\\?.lua;E:\\api\\lua\\demo\\ngx\\config\\?.lua";
--_GobalConfig = require("GobalConfig");--执行gobalConfig.lua

package.path = "/usr/local/nginx/conf/lua/?.lua;"
.. "/usr/local/nginx/conf/lua/games/?.lua;"
.. "/usr/local/nginx/conf/lua/config/?.lua;"
.. "/usr/local/nginx/conf/lua/utils/?.lua;"
.. "/usr/local/nginx/conf/lua/cache/?.lua;"
.. "/usr/lib64/lua/5.1/?.lua;";--memcache 库地址

_GobalConfig = require("GobalConfig");--执行gobalConfig.lua

_StringUtils = require("StringUtils");--字符串工具
_LogUtils = require("LogUtils");--log 工具

_Cache = require("Cache");--缓存
--[[用户输入数字映射--]]
local data = {
	 a = "labChange"
	,b = "labURL"
	,c = "labIP"
	,d = "labPhoneNo"
	,e = "labUserType"
	,f = "labBrandType"
	,g = "labPhoneNoType"
	,h = "labArea"
};


--[[
connector
types
urls
userTypes
brandTypes
phoneNoTypes
areas
change
--]]


--缓存服务器地址、端口
--策略类型
--[[
connector = (values[_GobalConfig.cacheKeys.connector] or {})[1];--执行 or分流 或 and分流
_types = (values[_GobalConfig.cacheKeys.types] or {})[1];

_urls = (values[_GobalConfig.cacheKeys.urls] or {})[1];
_labIP = (values[_GobalConfig.cacheKeys.ip .. _GobalConfig.splitChar .. _WebUtils:getClientIP()] or {})[1];--labIP@127.0.0.1
_phoneNo = (values[_GobalConfig.cacheKeys.phoneNo .. _GobalConfig.splitChar .. _GobalConfig.userInfo.phoneNo] or {})[1];
_userTypes = (values[_GobalConfig.cacheKeys.userTypes] or {})[1];
_brandTypes = (values[_GobalConfig.cacheKeys.brandTypes] or {})[1];
_phoneNoTypes = (values[_GobalConfig.cacheKeys.phoneNoTypes] or {})[1];
_areas = (values[_GobalConfig.cacheKeys.areas] or {})[1];
_changes = (values[_GobalConfig.cacheKeys.change] or {})[1];--暴力切换/直接切换

--]]

print ("请选择输入的策略类型（多个策略请用空格区别，例如: a b c）：");
print ("a 直接切换 b url策略 c ip地址策略 d 手机号码策略 e 用户类型策略 f 手机归属品牌策略 g 手机号段策略 h 手机归属地策略 ");
local inputNums = io.read("*line");--取当前文件的内容 "*all" "*line" "*number" number
local dataInput = _StringUtils:split(inputNums," ");
local types = "";
for i = 1,#dataInput,1 do
	local num = dataInput[i];
	local typeVal = data[num];
	if typeVal then
		types = types .. typeVal .. _GobalConfig.splitChar;
	end
end
print ("策略类型：" .. types);
print ("设置策略中....");
local res, flags, err = _Cache:set("types",types,0);--设置策略类型
if res == 1 then
	print ("设置策略成功...");
	
else
	print ("设置策略失败,原因：" .. err);
end






--[[o.laber = {labPhoneNo = "labPhoneNo"
				,labURL = "labURL"
				,labURLArg = "labURLArg"
				,labIP = "labIP"
				,labUserType = "labUserType"
				,labPhoneNoType = "labPhoneNoType"
				,labBrandType = "labBrandType"
				,labArea = "labArea"
				,labChange = "labChange"
				};--]]
--[[返回用户输入映射值--]]
function getType(num)
	if num == nil then
		return num;
	end
	return data[num];
end
--[[if num == 0 then
		_Cache:set(_GobalConfig.cacheKeys.types,_GobalConfig.laber.labChange,0);
	elseif num--]]
--print ("输入为:" .. inputNums);















