--全局配置
local GobalConfig = {};

function GobalConfig:new(o)
	o = o or {};
	setmetatable(o,self);
	self.__index = self;
	o.splitChar = "@";--字符串分隔符 _GobalConfig.splitChar
	o.cacheConfig = {ip="10.191.131.97",port="20001"};--缓存ip地址、端口
	--[[
	cacheKeys cache集合
	connector 连接符 and or 
	,types 执行策略集合
	,phoneNo 试验用户
	,urls url地址
	,urlArgs url参数
	,ip 试验ip
	,userTypes 用户类型
	,phoneNoTypes 用户手机号码号段
	,brandTypes 用户归属品牌类型
	,areas 用户归属区域
	,change 暴力引流/直接切换
	,beginTime 开始时间
	,endTime 结束时间
	,clientA 正式节点 
	,clientB 灰度节点 
	--]]
	o.cacheKeys = {
				   connector = "connector"
				  ,types = "types"
				  ,phoneNo = "phoneNo"
				  ,urls = "urls"
				  ,urlArgs = "urlArgs"
				  ,ip = "ip"
				  ,userTypes = "userTypes"
				  ,phoneNoTypes = "phoneNoTypes"
				  ,brandTypes = "brandTypes"
				  ,areas = "areas"
				  ,change = "change"
				  ,ipKey = ""
				  ,phoneNoKey = ""
				  ,beginTime = "beginTime"
				  ,endTime = "endTime"
				  ,clientA = "clientA"
				  ,clientB = "clientB"
				}; --cache key
	--[[labRouteName 试验地址
		currRouteName 当前执行路由名称
		produceRouteName 正式地址
	--]]
	o.router = {labRouteName = "@client_test"
			   ,currRouteName = "@client" 
			   ,produceRouteName= "@client"
			   };

	--[[
	用于配置cache中读取的值
		o.labPhoneNo = "labPhoneNo";--试验用户
	o.labURL = "labURL";--url地址 labPhoneNo@labIP@labURLArg@labBrandType
	o.labURLArg = "labURLArg";--url参数
	o.labIP = "labIP"; --试验ip
	o.labUserType = "labUserType";--用户类型
	o.labPhoneNoType = "labPhoneNoType";--用户手机号码号段
	o.labBrandType = "labBrandType";--用户归属品牌类型
	o.labArea = "labArea";--用户归属区域
	o.labChange = "labChange";--暴力引流/直接切换
	--]]
	o.laber = {labPhoneNo = "labPhoneNo"
				,labURL = "labURL"
				,labURLArg = "labURLArg"
				,labIP = "labIP"
				,labUserType = "labUserType"
				,labPhoneNoType = "labPhoneNoType"
				,labBrandType = "labBrandType"
				,labArea = "labArea"
				,labChange = "labChange"
				};
	--[[用户对象属性--]]
	o.userInfo = {phoneNo = ""
				   ,userType = ""
					,brandType = ""
					,phoneNoType = ""
					,area = ""
				  };
  --[[规则参数属性--]]
	o.gamesParam = {
		connector = ""
		,types = ""
		,area = ""
		,brandType = ""
		,phoneNo = ""
		,change = ""
		,ip = ""
		,phoneNoType = ""
		,urls = ""
		,urlArgs = ""
		,userType = ""
	};
	  --[[查询缓存结果对象值--]]
	o.cacheValues = {};
	
	
	return o;
end
function GobalConfig:getGobalConfig()
	return GobalConfig:new();
end
return GobalConfig;