local WebUtils = {};

--[[��ȡ�ͻ���ip��ַ--]]
function WebUtils:getClientIP()
	--[[local clientIP = ngx.req.get_headers()["X-Real-IP"]
	if (clientIP == nil) then
		clientIP = ngx.req.get_headers()["X-Forwarded-For"]
	end
	if (clientIP == nil) then
		clientIP = ngx.var.remote_addr
	end
	return clientIP;
	--]]
	return ngx.var.remote_addr;
	
end
--[[��ȡ�ͻ���������汾--]]
function WebUtils:getBrowserName()
	local browserName = "other";
	local user_agent = ngx.var.http_user_agent;
	if(ngx.re.match(user_agent,"Chrome"))then
		browserName = "chrome";
	elseif(ngx.re.match(user_agent,"Firefox")) then
		browserName = "firefox";
	elseif(ngx.re.match(user_agent,"MSIE")) then
		browserName = "msie";
	else
		browserName = "other";
	end
	return browserName;
end

--[[��ȡuri--]]
function WebUtils:getUri()
	return ngx.var.request_uri;
end

--[[��ȡ���в���--]]
function WebUtils:getPars()
	local data = {};
	local request_method = ngx.var.request_method;
	local args = nil;
	if("GET" == request_method) then
		args = ngx.req.get_uri_args();
	elseif("POST" == request_method) then 
		args = ngx.req.get_post_args();
	end
    for key, val in pairs(args) do
		if type(val) == "table" then
			data[key] =  table.concat(val, ", ");
		else
			data[key] = val;
		end
    end
end


return WebUtils;