--[[
�򵥹���ģʽ
--]]
--package.path = "E:\\api\\lua\\demo\\ngx\\?.lua;E:\\api\\lua\\demo\\ngx\\games\\?.lua;E:\\api\\lua\\demo\\ngx\\config\\?.lua";
--_GobalConfig = require("GobalConfig");--ִ��gobalConfig.lua

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
o.labPhoneNo = "labPhoneNo";--�����û�
	
	o.labURL = "labURL";--url��ַ
	o.labURLArg = "labURLArg";--url����
	o.labIP = "labIP"; --����ip
	o.labUserType = "labUserType";--�û�����
	o.labPhoneNoType = "labPhoneNoType";--�û��ֻ�����Ŷ�
	o.labBrandType = "labBrandType";--�û�����Ʒ������
	o.labArea = "labArea";--�û���������
	o.labChange = "labChange";--��������/ֱ���л�
	phoneNo/url/urlArg/ip/userType/phoneNoType/brandType/area/change/default
--]]
--[[�ֻ�����--]]
function GameLabPhoneNo:work(obj)
	_LogUtils:debugInfo("GameLabUser work exec");
	local PhoneNo = require("PhoneNo");--ִ��phoneNo.lua
	local execName = PhoneNo:work(obj);
	return execName;
end
--[[url��ַ--]]
function GameLabURL:work(obj)
	_LogUtils:debugInfo("GameLabURL work exec");
	local Url = require("Url");--ִ��url.lua
	local execName = Url:work(obj);
	return execName;
end
--[[url����--]]
function GameLabURLArg:work(obj)
	_LogUtils:debugInfo("GameLabURLArg work exec");
	local UrlArg = require("UrlArg");--ִ��urlArg.lua
	local execName = UrlArg:work(obj);
	return execName;
end
--[[����ip--]]
function GameLabIP:work(obj)
	_LogUtils:debugInfo("GameLabIP work exec");
	local Ip = require("Ip");--ִ��ip.lua
	local execName = Ip:work(obj);
	return execName;
end
--[[�û�����--]]
function GameLabUserType:work(obj)
	_LogUtils:debugInfo("GameLabUserType work exec");
	local UserType = require("UserType");--ִ��userType.lua
	local execName = UserType:work(obj);
	return execName;
end
--[[�û��ֻ�����Ŷ�--]]
function GameLabPhoneNoType:work(obj)
	_LogUtils:debugInfo("GameLabPhoneNoType work exec");
	local PhoneNoType = require("PhoneNoType");--ִ��phoneNoType.lua
	local execName = PhoneNoType:work(obj);
	return execName;
end
--[[�û�����Ʒ������--]]
function GameLabBrandType:work(obj)
	_LogUtils:debugInfo("GameLabBrandType work exec");
	local BrandType = require("BrandType");--ִ��brandType.lua
	local execName = BrandType:work(obj);
	return execName;
end
--[[�û���������--]]
function GameLabArea:work(obj)
	_LogUtils:debugInfo("GameLabArea work exec");
	local Area = require("Area");--ִ��area.lua
	local execName = Area:work(obj);
	return execName;
end
--[[��������/ֱ���л�--]]
function GameLabChange:work(obj)
	_LogUtils:debugInfo("GameLGameLabChangeabArea work exec");
	local Change = require("Change");--ִ��change.lua
	local execName = Change:work(obj);
	return execName;
end
--[[Ĭ��ִ��--]]
function GameDefault:work(obj)
	_LogUtils:debugInfo("GameDefault work exec");
	local Default = require("Default");--ִ��default.lua
	local execName = Default:work(obj);
	return execName;
end	
--[[	o.labPhoneNo = "labPhoneNo";--�����û�
	o.labURL = "labURL";--url��ַ
	o.labURLArg = "labURLArg";--url����
	
	o.labIP = "labIP"; --����ip
	o.labUserType = "labUserType";--�û�����
	o.labPhoneNoType = "labPhoneNoType";--�û��ֻ�����Ŷ�
	o.labBrandType = "labBrandType";--�û�����Ʒ������
	o.labArea = "labArea";--�û���������
	o.labChange = "labChange";--��������/ֱ���л�--]]
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
