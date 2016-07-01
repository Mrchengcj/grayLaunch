--[[
简单工厂模式
--]]
--package.path = "E:\\api\\lua\\demo\\ngx\\?.lua;E:\\api\\lua\\demo\\ngx\\games\\?.lua;E:\\api\\lua\\demo\\ngx\\config\\?.lua";
--_GobalConfig = require("GobalConfig");--执行gobalConfig.lua

local GameFacotry = {};

local Game = {};

function Game:new(o)
	o = o or {};
	setmetatable(o,self);
	self.__index = self;
	return o;
end 

GameLabPhoneNo = Game:new();

GameLabURL = Game:new();

GameLabURLArg = Game:new();

GameLabIP = Game:new();

GameLabUserType = Game:new();

GameLabPhoneNoType = Game:new();

GameLabBrandType = Game:new();

GameLabArea = Game:new();

GameLabChange = Game:new();

GameDefault = Game:new();
--[[
o.labPhoneNo = "labPhoneNo";--试验用户
	
	o.labURL = "labURL";--url地址
	o.labURLArg = "labURLArg";--url参数
	o.labIP = "labIP"; --试验ip
	o.labUserType = "labUserType";--用户类型
	o.labPhoneNoType = "labPhoneNoType";--用户手机号码号段
	o.labBrandType = "labBrandType";--用户归属品牌类型
	o.labArea = "labArea";--用户归属区域
	o.labChange = "labChange";--暴力引流/直接切换
	phoneNo/url/urlArg/ip/userType/phoneNoType/brandType/area/change/default
--]]
--[[手机号码--]]
function GameLabPhoneNo:work(obj)
	_LogUtils:debugInfo("GameLabUser work exec");
	local PhoneNo = require("PhoneNo");--执行phoneNo.lua
	local execName = PhoneNo:work(obj);
	return execName;
end
--[[url地址--]]
function GameLabURL:work(obj)
	_LogUtils:debugInfo("GameLabURL work exec");
	local Url = require("Url");--执行url.lua
	local execName = Url:work(obj);
	return execName;
end
--[[url参数--]]
function GameLabURLArg:work(obj)
	_LogUtils:debugInfo("GameLabURLArg work exec");
	local UrlArg = require("UrlArg");--执行urlArg.lua
	local execName = UrlArg:work(obj);
	return execName;
end
--[[试验ip--]]
function GameLabIP:work(obj)
	_LogUtils:debugInfo("GameLabIP work exec");
	local Ip = require("Ip");--执行ip.lua
	local execName = Ip:work(obj);
	return execName;
end
--[[用户类型--]]
function GameLabUserType:work(obj)
	_LogUtils:debugInfo("GameLabUserType work exec");
	local UserType = require("UserType");--执行userType.lua
	local execName = UserType:work(obj);
	return execName;
end
--[[用户手机号码号段--]]
function GameLabPhoneNoType:work(obj)
	_LogUtils:debugInfo("GameLabPhoneNoType work exec");
	local PhoneNoType = require("PhoneNoType");--执行phoneNoType.lua
	local execName = PhoneNoType:work(obj);
	return execName;
end
--[[用户归属品牌类型--]]
function GameLabBrandType:work(obj)
	_LogUtils:debugInfo("GameLabBrandType work exec");
	local BrandType = require("BrandType");--执行brandType.lua
	local execName = BrandType:work(obj);
	return execName;
end
--[[用户归属区域--]]
function GameLabArea:work(obj)
	_LogUtils:debugInfo("GameLabArea work exec");
	local Area = require("Area");--执行area.lua
	local execName = Area:work(obj);
	return execName;
end
--[[暴力引流/直接切换--]]
function GameLabChange:work(obj)
	_LogUtils:debugInfo("GameLGameLabChangeabArea work exec");
	local Change = require("Change");--执行change.lua
	local execName = Change:work(obj);
	return execName;
end
--[[默认执行--]]
function GameDefault:work(obj)
	_LogUtils:debugInfo("GameDefault work exec");
	local Default = require("Default");--执行default.lua
	local execName = Default:work(obj);
	return execName;
end	
--[[	o.labPhoneNo = "labPhoneNo";--试验用户
	o.labURL = "labURL";--url地址
	o.labURLArg = "labURLArg";--url参数
	
	o.labIP = "labIP"; --试验ip
	o.labUserType = "labUserType";--用户类型
	o.labPhoneNoType = "labPhoneNoType";--用户手机号码号段
	o.labBrandType = "labBrandType";--用户归属品牌类型
	o.labArea = "labArea";--用户归属区域
	o.labChange = "labChange";--暴力引流/直接切换--]]
function GameFacotry:createGame(gameName)
	if(gameName == _GobalConfig.laber.labPhoneNo) then
		return GameLabPhoneNo:new();
	elseif(gameName == _GobalConfig.laber.labURL) then
		return GameLabURL:new();
	elseif(gameName == _GobalConfig.laber.labURLArg) then
		return GameLabURLArg:new();
	elseif(gameName == _GobalConfig.laber.labIP) then
		return GameLabIP:new();
	elseif(gameName == _GobalConfig.laber.labUserType) then
		return GameLabUserType:new();
	elseif(gameName == _GobalConfig.laber.labPhoneNoType) then
		return GameLabPhoneNoType:new();
	elseif(gameName == _GobalConfig.laber.labBrandType) then
		return GameLabBrandType:new();
	elseif(gameName == _GobalConfig.laber.labArea) then
		return GameLabArea:new();
	--elseif(gameName == _GobalConfig.laber.labChange) then
		--return GameLabChange:new();
	else
		return GameDefault:new();
	end
end

return GameFacotry;
