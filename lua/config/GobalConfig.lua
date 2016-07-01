--ȫ������
local GobalConfig = {};

function GobalConfig:new(o)
	o = o or {};
	setmetatable(o,self);
	self.__index = self;
	o.splitChar = "@";--�ַ����ָ��� _GobalConfig.splitChar
	o.cacheConfig = {ip="10.191.131.97",port="20001"};--����ip��ַ���˿�
	--[[
	cacheKeys cache����
	connector ���ӷ� and or 
	,types ִ�в��Լ���
	,phoneNo �����û�
	,urls url��ַ
	,urlArgs url����
	,ip ����ip
	,userTypes �û�����
	,phoneNoTypes �û��ֻ�����Ŷ�
	,brandTypes �û�����Ʒ������
	,areas �û���������
	,change ��������/ֱ���л�
	,beginTime ��ʼʱ��
	,endTime ����ʱ��
	,clientA ��ʽ�ڵ� 
	,clientB �ҶȽڵ� 
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
	--[[labRouteName �����ַ
		currRouteName ��ǰִ��·������
		produceRouteName ��ʽ��ַ
	--]]
	o.router = {labRouteName = "@client_test"
			   ,currRouteName = "@client" 
			   ,produceRouteName= "@client"
			   };

	--[[
	��������cache�ж�ȡ��ֵ
		o.labPhoneNo = "labPhoneNo";--�����û�
	o.labURL = "labURL";--url��ַ labPhoneNo@labIP@labURLArg@labBrandType
	o.labURLArg = "labURLArg";--url����
	o.labIP = "labIP"; --����ip
	o.labUserType = "labUserType";--�û�����
	o.labPhoneNoType = "labPhoneNoType";--�û��ֻ�����Ŷ�
	o.labBrandType = "labBrandType";--�û�����Ʒ������
	o.labArea = "labArea";--�û���������
	o.labChange = "labChange";--��������/ֱ���л�
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
	--[[�û���������--]]
	o.userInfo = {phoneNo = ""
				   ,userType = ""
					,brandType = ""
					,phoneNoType = ""
					,area = ""
				  };
  --[[�����������--]]
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
	  --[[��ѯ����������ֵ--]]
	o.cacheValues = {};
	
	
	return o;
end
function GobalConfig:getGobalConfig()
	return GobalConfig:new();
end
return GobalConfig;