--[[
Cache
--]]
--package.path = "E:\\api\\lua\\demo\\ngx\\cache\\?.lua";

local Cache = {};

--[[��ȡcache--]]
function Cache:getCache()
  local memcached = require "memcached";
	local o,err= memcached:new();

	if not o then
		ngx.say("failed to instantiate memc: ", err);
		return;
	end
	o:set_timeout(2000);--��ʱʱ�䣬��λ������
	local ok, err = o:connect(_GobalConfig.cacheConfig.ip, _GobalConfig.cacheConfig.port);
	--���� 1 ʧ��nil
	if not ok then
		_LogUtils:err("failed to acc memc: " .. err);
		--ngx.say("failed to acc memc: ", err);
		return;
	end
	return o;
end
--[[��ȡcache--]]
function Cache:set(key, value,timeout)
	local o = Cache:getCache();
	if not o then
	  _LogUtils:err("o is nil ");
		--ngx.say("o is nil ", err);
		return;
	end
		
	local res, flags, err = o:set(key,value,timeout);
	if err then
		_LogUtils:err("failed to set ".. (key or {}), err);
		
		return;
	end
	return res;
	
end
--[[��ȡcache--]]
function Cache:get(key)
	local o = Cache:getCache();
	if not o then
	  _LogUtils:err("o is nil ");
		--ngx.say("o is nil ", err);
		return;
	end
	_LogUtils:info("get key = " .. (key or ""));
	local res, flags, err = o:get(key);
	if err then
		LogUtils:err("failed to get " ..  key .. "," .. err);
		--ngx.say("failed to get " ..  key, err)
		return;
	end
	return res;
end

--[[������ȡcache--]]
function Cache:gets(keys)
	
	local o = Cache:getCache();
	if not o then
	  _LogUtils:err("o is nil ");
		--ngx.say("o is nil ", err);
		return;
	end
	
	local res, flags, err = o:gets(keys);
	--print( "xxxxxxxxxxx=" .. res["types2"][1]);
	--local res = o:gets(keys);
	--_LogUtils:info("a++++++++++++++++++");
	--_LogUtils:info("a++++++++++++++++++");
	--_LogUtils:info(res);
	_LogUtils:info(flags);--timeout
	--_LogUtils:info("b++++++++++++++++++");
	--_LogUtils:info("err="+err);
	if flags ~= nil and flags == "timeout" then
		_LogUtils:info("++++++++cache���ӳ�ʱ++++++++");
	end 
	if err then
		return;
	end
	
	return res;
end

return Cache;






