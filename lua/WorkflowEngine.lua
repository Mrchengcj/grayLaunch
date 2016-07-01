--[[
工作流引擎入口
--]]
local prefixNgx = ngx.config.prefix(); 
package.path = prefixNgx .. "conf/lua/?.lua;"
.. prefixNgx .. "conf/lua/games/?.lua;"
.. prefixNgx .. "conf/lua/config/?.lua;"
.. prefixNgx .. "conf/lua/utils/?.lua;"
.. prefixNgx .. "conf/lua/cache/?.lua;";
--.. "/usr/lib64/lua/5.1/?.lua;";--memcache 库地址

_Config = require("GobalConfig");--执行gobalConfig.lua
_GobalConfig = _Config:getGobalConfig();

_GameFactory = require("GameFactory");--工厂类

_StringUtils = require("StringUtils");--字符串工具
_WebUtils = require("WebUtils");--web 工具
_LogUtils = require("LogUtils");--log 工具

_Cache = require("Cache");--缓存

_UserInfo = require("UserInfo");--用户对象信息
_GobalConfig.userInfo = _UserInfo:getUserInfo();--获取cookie中用户信息

_LogUtils:debugInfo("==================userInfo value begin========================");
_LogUtils:debugInfo("phoneNo=" .. (_GobalConfig.userInfo.phoneNo or ""));
_LogUtils:debugInfo("userType=" .. (_GobalConfig.userInfo.userType or ""));
_LogUtils:debugInfo("brandType=" .. (_GobalConfig.userInfo.brandType or ""));
_LogUtils:debugInfo("phoneNoType=" .. (_GobalConfig.userInfo.phoneNoType or ""));
_LogUtils:debugInfo("area=" .. (_GobalConfig.userInfo.area or ""));
_LogUtils:debugInfo("==================userInfo value end========================");

_GobalConfig.cacheKeys.ipKey = (_GobalConfig.cacheKeys.ip .. _GobalConfig.splitChar .. _WebUtils:getClientIP());
_GobalConfig.cacheKeys.phoneNoKey = (_GobalConfig.cacheKeys.phoneNo .. _GobalConfig.splitChar .. _GobalConfig.userInfo.phoneNo);


_LogUtils:debugInfo("==================ip value begin========================");
_LogUtils:debugInfo("X-Real-IP=" .. ((ngx.req.get_headers()["X-Real-IP"]) or ""));
_LogUtils:debugInfo("X-Forwarded-For=" .. ((ngx.req.get_headers()["X-Forwarded-For"]) or ""));
_LogUtils:debugInfo("remote_addr=" .. (ngx.var.remote_addr or ""));
_LogUtils:debugInfo("==================ip value end========================");



_LogUtils:debugInfo("==================key value begin========================");
_LogUtils:debugInfo("connector=" .. _GobalConfig.cacheKeys.connector);
_LogUtils:debugInfo("types=" .. _GobalConfig.cacheKeys.types);
_LogUtils:debugInfo("urls=" .. _GobalConfig.cacheKeys.urls);
_LogUtils:debugInfo("ip=[" .. _GobalConfig.cacheKeys.ipKey .. "]");
_LogUtils:debugInfo("phoneNo=[" .. _GobalConfig.cacheKeys.phoneNoKey .. "]");
_LogUtils:debugInfo("userTypes=" .. _GobalConfig.cacheKeys.userTypes);
_LogUtils:debugInfo("brandTypes=" .. _GobalConfig.cacheKeys.brandTypes);
_LogUtils:debugInfo("phoneNoTypes=" .. _GobalConfig.cacheKeys.phoneNoTypes);
_LogUtils:debugInfo("areas=" .. _GobalConfig.cacheKeys.areas);
_LogUtils:debugInfo("change=" .. _GobalConfig.cacheKeys.change);
_LogUtils:debugInfo("==================key value end========================");
--[[
读取cache配置信息
--]]

_LogUtils:debugInfo("values begin");
_GobalConfig.cacheValues = _Cache:gets({
_GobalConfig.cacheKeys.connector
,_GobalConfig.cacheKeys.types
,_GobalConfig.cacheKeys.urls
,_GobalConfig.cacheKeys.ipKey
,_GobalConfig.cacheKeys.phoneNoKey
,_GobalConfig.cacheKeys.userTypes
,_GobalConfig.cacheKeys.brandTypes
,_GobalConfig.cacheKeys.phoneNoTypes
,_GobalConfig.cacheKeys.areas
,_GobalConfig.cacheKeys.change
,_GobalConfig.cacheKeys.beginTime
,_GobalConfig.cacheKeys.endTime
,_GobalConfig.cacheKeys.clientA
,_GobalConfig.cacheKeys.clientB
}) or {};
_LogUtils:debugInfo("values end");

local defaultRouteName = _GobalConfig.router.currRouteName;
_GobalConfig.router.produceRouteName = ((_GobalConfig.cacheValues[_GobalConfig.cacheKeys.clientA] or {})[1]) or _GobalConfig.router.produceRouteName;
_GobalConfig.router.labRouteName = ((_GobalConfig.cacheValues[_GobalConfig.cacheKeys.clientB] or {})[1]) or _GobalConfig.router.labRouteName;
_GobalConfig.router.currRouteName = _GobalConfig.router.produceRouteName;
local currRouteName = _GobalConfig.router.currRouteName;
local beginTime = tonumber((_GobalConfig.cacheValues[_GobalConfig.cacheKeys.beginTime] or {})[1]);
local endTime = tonumber((_GobalConfig.cacheValues[_GobalConfig.cacheKeys.endTime] or {})[1]);

_GobalConfig.gamesParam.connector = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.connector] or {})[1];--执行 or分流 或 and分流
_GobalConfig.gamesParam.types = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.types] or {})[1];

_GobalConfig.gamesParam.phoneNo = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.phoneNoKey] or {})[1];
_GobalConfig.gamesParam.area = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.areas] or {})[1];
_GobalConfig.gamesParam.brandType = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.brandTypes] or {})[1];
_GobalConfig.gamesParam.change = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.change] or {})[1];--暴力切换/直接切换
_GobalConfig.gamesParam.ip = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.ipKey] or {})[1];--labIP@127.0.0.1
_GobalConfig.gamesParam.phoneNoType = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.phoneNoTypes] or {})[1];
_GobalConfig.gamesParam.urls = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.urls] or {})[1];
_GobalConfig.gamesParam.userType = (_GobalConfig.cacheValues[_GobalConfig.cacheKeys.userTypes] or {})[1];

_LogUtils:debugInfo("==================cache value begin========================");
_LogUtils:debugInfo("_GobalConfig.gamesParam.connector=" .. (_GobalConfig.gamesParam.connector  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.types=" .. (_GobalConfig.gamesParam.types  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.phoneNo=" .. (_GobalConfig.gamesParam.phoneNo  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.area=" .. (_GobalConfig.gamesParam.area  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.brandType=" .. (_GobalConfig.gamesParam.brandType  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.change=" .. (_GobalConfig.gamesParam.change  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.ip=" .. (_GobalConfig.gamesParam.ip  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.phoneNoType=" .. (_GobalConfig.gamesParam.phoneNoType  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.urls=" .. (_GobalConfig.gamesParam.urls  or "" ));
_LogUtils:debugInfo("_GobalConfig.gamesParam.userType=" .. (_GobalConfig.gamesParam.userType  or "" ));
_LogUtils:debugInfo("_GobalConfig.router.produceRouteName=" .. (_GobalConfig.router.produceRouteName  or "" ));
_LogUtils:debugInfo("_GobalConfig.router.labRouteName=" .. (_GobalConfig.router.labRouteName  or "" ));
_LogUtils:debugInfo("defaultRouteName=" .. (defaultRouteName or "" ));
_LogUtils:debugInfo("currRouteName=" .. (currRouteName or "" ));
_LogUtils:debugInfo("beginTime=" .. (beginTime or ""));
_LogUtils:debugInfo("endTime=" .. (endTime or ""));
_LogUtils:debugInfo("==================cache value end========================");

--[[
memcache操作脚本编写
脚本类型：lua 、bat 、shell
--]]

if(_GobalConfig.gamesParam.connector == nil or _GobalConfig.gamesParam.connector == "") then
	_GobalConfig.gamesParam.connector = "and";
end

--暴力引流/直接切换
if(_GobalConfig.gamesParam.types ~= nil and (_GobalConfig.gamesParam.types == _GobalConfig.laber.labChange or string.find(_GobalConfig.gamesParam.types,_GobalConfig.laber.labChange) ~= nil)) then
	_LogUtils:debugInfo("curr is change ");
	if(_GobalConfig.gamesParam.change ~= nil and _GobalConfig.gamesParam.change ~= "") then
		_LogUtils:debugInfo("_changes =[" .. _GobalConfig.gamesParam.change .. "]");
		ngx.var.upstreameName = _GobalConfig.gamesParam.change;
		ngx.exec(_GobalConfig.gamesParam.change);
	else
		_LogUtils:err("labChange is nil or empty ");
		ngx.var.upstreameName = _GobalConfig.router.produceRouteName;
		ngx.exec(_GobalConfig.router.produceRouteName);
	end
	return;
end

--验证策略开始结束时间
if(beginTime ~= nil and endTime ~= nil) then
	currentTime = (ngx.var.msec * 1000);--获取当前系统时间
	_LogUtils:debugInfo("currentTime =[" .. currentTime .. "]");
	if(currentTime < beginTime or currentTime > endTime)then
	  _LogUtils:debugInfo("当前策略不在执行时间中。。。。");
		ngx.var.upstreameName = defaultRouteName;
		ngx.exec(defaultRouteName);
		return;
	end
	 _LogUtils:debugInfo("当前策略在执行时间范围内。。。。");
end

gamesName = {};
if(_GobalConfig.gamesParam.types ~= nil and _GobalConfig.gamesParam.types ~= "") then
	gamesName = _StringUtils:split(_GobalConfig.gamesParam.types,_GobalConfig.splitChar);
end

_LogUtils:debugInfo("currRouteName = " .. currRouteName or "");
for i = 1 , #gamesName , 1 do
	if(gamesName[i] ~= nil and gamesName[i] ~= "") then
		_LogUtils:debugInfo("execName[" .. i .. "]= " .. gamesName[i]);
		currRouteName = _GameFactory:createGame(gamesName[i]):work(_GobalConfig) or _GobalConfig.router.produceRouteName;
		if(_GobalConfig.gamesParam.connector == "and") then --and 分流
			if(currRouteName == _GobalConfig.router.produceRouteName) then --当前路由名称 == 生产路由 ，中断后续执行，退出
				break;
			end
		elseif(_GobalConfig.gamesParam.connector == "or") then --or 分流
			if(currRouteName == _GobalConfig.router.labRouteName) then --当前路由名称 == 试验/测试路由 ，中断后续执行，退出
				_LogUtils:debugInfo("currRouteName2 = " .. currRouteName or "");
				break;
			end
		else
			_LogUtils:err("_GobalConfig.gamesParam.connector not in and or ,_GobalConfig.gamesParam.connector=[" .. _GobalConfig.gamesParam.connector .. "]");
			break;
		end
	else
		_LogUtils:debugInfo("execName[" .. i .. "]= nil");
	end
	
	
end
_LogUtils:debugInfo("currRouteName = " .. currRouteName or "");
if(currRouteName ~= nil and currRouteName ~= "") then
	if(currRouteName == _GobalConfig.router.labRouteName) then
		ngx.header["Expires"] = 0;
		ngx.header["Cache-Control"] = "no-store";
	end
	ngx.var.upstreameName = currRouteName;
	ngx.exec(currRouteName);--执行最终确认的执行器
else
	ngx.say("currRouteName is nil");
end

