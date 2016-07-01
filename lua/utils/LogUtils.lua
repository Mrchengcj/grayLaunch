local LogUtils = {};

--[[日志打印
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
--[[日志常规信息--]]
function LogUtils:info(msg)
	ngx.log(ngx.INFO,msg);
end

--[[日志调试信息--]]
function LogUtils:debugInfo(msg)
	ngx.log(ngx.DEBUG,msg);
end

--[[日志错误信息--]]
function LogUtils:err(msg)
	ngx.log(ngx.ERR,"@@@@@@@@[" .. (msg or "").. "]@@@@@@@@");
end

--[[日志错误信息--]]
function LogUtils:warn(msg)
	ngx.log(ngx.WARN,msg);
end

return LogUtils;