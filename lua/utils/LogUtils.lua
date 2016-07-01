local LogUtils = {};

--[[��־��ӡ
ngx.STDERR
  ngx.EMERG
  ngx.ALERT
  ngx.CRIT
  ngx.ERR
  ngx.WARN
  ngx.NOTICE
  ngx.INFO
  ngx.DEBUG
--]]
--[[��־������Ϣ--]]
function LogUtils:info(msg)
	ngx.log(ngx.INFO,msg);
end

--[[��־������Ϣ--]]
function LogUtils:debugInfo(msg)
	ngx.log(ngx.DEBUG,msg);
end

--[[��־������Ϣ--]]
function LogUtils:err(msg)
	ngx.log(ngx.ERR,"@@@@@@@@[" .. (msg or "").. "]@@@@@@@@");
end

--[[��־������Ϣ--]]
function LogUtils:warn(msg)
	ngx.log(ngx.WARN,msg);
end

return LogUtils;