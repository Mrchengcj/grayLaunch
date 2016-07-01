#!/bin/sh
#local data = {
#	 a = "labChange"
#	,b = "labURL"
#	,c = "labIP"
#	,d = "labPhoneNo"
#	,e = "labUserType"
#	,f = "labBrandType"
#	,g = "labPhoneNoType"
#	,h = "labArea"
#};

cacheIP="10.112.105.86"
cachePort="11211"
DATETIME=`date "+%Y%m%d"`
splitChar="@"
#策略文件地址
pathPrefix="/tengine/system/nginx/conf/lua/exec/data/"


#cacheIP="127.0.0.1"
#cachePort="11211"
#DATETIME=`date "+%Y%m%d"`
#pathPrefix="/usr/local/nginx/conf/lua/exec/data/"

echo "请选择输入的策略类型（多个策略请用空格区别，例如: a b c）："
echo "a 直接切换 b url策略 c ip地址策略 d 手机号码策略 e 用户类型策略 f 手机归属品牌策略 g 手机号段策略 h 手机归属地策略"
echo "特别说明：如果策略中包含 a 选项，其他选项在分流引擎中将不做处理。"
read userInput

types=""
echo "开始缓存清空中。。。"
MEMCACHED_SET_AND_GET0x=`(sleep 1;echo "flush_all";sleep 1;) | telnet $cacheIP $cachePort | awk 'NR==4 {print $1}'` 
echo "缓存清理结果=[$MEMCACHED_SET_AND_GET0x]"       
                                                    
if [ "$MEMCACHED_SET_AND_GET0x" = "OK" ]                                                                        
then                                                                                                              
echo -e "服务器$cacheIP的缓存端口$cachePort 清空缓存成功！\n"                                                              
else                                                                                                              
echo -e "服务器$cacheIP的缓存端口$cachePort存取数据异常，清空缓存失败！\n"                                                              
fi 
echo "结束缓存清空中。。。"

echo "开始读取配置文件策略信息到缓存。。。"
for v in $userInput
do
	value=""
	fileName=""
	cacheKey=""
	if [ "$v"x == "a"x ]
	then
		value="labChange"
		fileName="change.txt"
		cacheKey="change"
	elif [ "$v"x == "b"x ]
	then
	 	value="labURL"
	 	fileName="urls.txt"
	 	cacheKey="urls"
	elif [ "$v"x == "c"x ]
	then
	 	value="labIP"
	 	fileName="ips.txt"
	 	cacheKey=""
	elif [ "$v"x == "d"x ]
	then
	 	value="labPhoneNo"
	 	fileName="phoneNos.txt"
	 	cacheKey=""
	elif [ "$v"x == "e"x ]
	then
	 	value="labUserType"
	 	fileName="userTypes.txt"
	 	cacheKey="userTypes"
	elif [ "$v"x == "f"x ]
	then
	 	value="labBrandType"
	 	fileName="brandTypes.txt"
	 	cacheKey="brandTypes"
	elif [ "$v"x == "g"x ]
	then
	 	value="labPhoneNoType"
	 	fileName="phoneTypes.txt"
	 	cacheKey="phoneNoTypes"
	elif [ "$v"x == "h"x ]
	then
	 	value="labArea"
	 	fileName="areas.txt"
	 	cacheKey="areas"
	fi
	
	if [ "$fileName"x != ""x ]
	then
		cacheValue=""
		if [ "$value"x != "labChange"x ] && [ "$value"x != "labIP"x ] && [ "$value"x != "labPhoneNo"x ]
		then
			cacheValue=""
			#读取配置文件
			for line in `cat $pathPrefix$fileName`
			do
				if [ "$line"x != ""x ]
				then
					cacheValue="$cacheValue$line$splitChar"
					
				fi
			done
			cacheValue="$splitChar$cacheValue";
			echo "key=$cacheKey,value=$cacheValue,length=${#cacheValue}";
			MEMCACHED_SET_AND_GET0=`(sleep 1;echo "set $cacheKey 0 0 ${#cacheValue}";sleep 1; echo "$cacheValue";sleep 1;echo "get $cacheKey";sleep 1;) | telnet $cacheIP $cachePort |awk 'NR==6 {print $1}'`
			if [ "$MEMCACHED_SET_AND_GET0"x != "$cacheValue"x ]
			then
				echo -e "服务器$cacheIP的缓存端口$cachePort存取数据异常，存入数据【$cacheValue】，获取数据【$MEMCACHED_SET_AND_GET0】!\n"
			fi
			
		elif [ "$value"x == "labChange"x ]
		then
				cacheValue=""
				#读取配置文件
				for line in `cat $pathPrefix$fileName`
				do
					if [ "$line"x != "" ]
					then
						cacheValue=$line
						break
					fi
				done

				echo "key=$cacheKey,value=$cacheValue,length=${#cacheValue}";
				MEMCACHED_SET_AND_GET0=`(sleep 1;echo "set $cacheKey 0 0 ${#cacheValue}";sleep 1; echo "$cacheValue";sleep 1;echo "get $cacheKey";sleep 1;) | telnet $cacheIP $cachePort |awk 'NR==6 {print $1}'`
				if [ "$MEMCACHED_SET_AND_GET0"x != "$cacheValue"x ]
				then
					echo -e "服务器$cacheIP的缓存端口$cachePort存取数据异常，存入数据【$cacheValue】，获取数据【$MEMCACHED_SET_AND_GET0】!\n"
				fi
		fi
		
		if [ "$value"x == "labIP"x ]
		then
				cacheValue=""
				#读取配置文件
				for line in `cat $pathPrefix$fileName`
				do
					if [ "$line"x != "" ]
					then
						cacheKey="ip$splitChar"$line
						cacheValue="1"
						echo "key=$cacheKey,value=$cacheValue,length=${#cacheValue}";
						MEMCACHED_SET_AND_GET0=`(sleep 1;echo "set $cacheKey 0 0 ${#cacheValue}";sleep 1; echo "$cacheValue";sleep 1;echo "get $cacheKey";sleep 1;) | telnet $cacheIP $cachePort |awk 'NR==6 {print $1}'`
						if [ "$MEMCACHED_SET_AND_GET0"x != "$cacheValue"x ]
						then
							echo -e "服务器$cacheIP的缓存端口$cachePort存取数据异常，存入数据【$cacheValue】，获取数据【$MEMCACHED_SET_AND_GET0】!\n"
							break
						fi
					fi
				done
		fi
		
		if [ "$value"x == "labPhoneNo"x ]
		then
				cacheValue=""
				#读取配置文件
				for line in `cat $pathPrefix$fileName`
				do
					if [ "$line"x != ""x ]
					then
						cacheKey="phoneNo$splitChar"$line
						cacheValue="1"
						echo "key=$cacheKey,value=$cacheValue,length=${#cacheValue}";
						MEMCACHED_SET_AND_GET0=`(sleep 1;echo "set $cacheKey 0 0 ${#cacheValue}";sleep 1; echo "$cacheValue";sleep 1;echo "get $cacheKey";sleep 1;) | telnet $cacheIP $cachePort |awk 'NR==6 {print $1}'`
						if [ "$MEMCACHED_SET_AND_GET0"x != "$cacheValue"x ]
						then
							echo -e "服务器$cacheIP的缓存端口$cachePort存取数据异常，存入数据【$cacheValue】，获取数据【$MEMCACHED_SET_AND_GET0】！\n"
							break
						fi
					fi
				done
		fi
		
		
	fi
	
	if [ "$value"x != ""x ]
	then
		types=$types$value"$splitChar"
	fi
	
done
echo "结束读取配置文件策略信息到缓存。"

echo "策略：【$types】"
#types="abc";echo ${#types}


#设置types
MEMCACHED_SET_AND_GET=`(sleep 1;echo "set types 0 0 ${#types}";sleep 1; echo "$types";sleep 1;echo "get types";sleep 1;) | telnet $cacheIP $cachePort |awk 'NR==6 {print $1}'`
if [ "$MEMCACHED_SET_AND_GET" = "$types" ]
then
	echo "服务器$cacheIP的缓存端口$cachePort存取数据正常！"
	echo "请选择分流策略执行方式（例如: a b ）："
	echo "a AND分流 b OR分流"
	read userInput2
	connector="and"
	if [ "b"x == "$userInput2"x ]
	then
		connector="or";
	fi
	echo "开始写入数据到缓存。"
	#设置connector
	MEMCACHED_SET_AND_GET2=`(sleep 1;echo "set connector 0 0 ${#connector}";sleep 1; echo "$connector";sleep 1;echo "get connector";sleep 1;) | telnet $cacheIP $cachePort |awk 'NR==6 {print $1}'`
	if [ "$MEMCACHED_SET_AND_GET2" = "$connector" ]
	then
		echo -e "服务器$cacheIP的缓存端口$cachePort存取数据正常！\n"  
		echo -e "------------恭喜配置成功！--------------------\n"    
		echo -e "策略：【$types】\n"
		echo -e "分流策略执行方式：【$connector】\n"  
		#echo -e "请确认已经到文件中配置策略数据！yes or no?\n"
		#read userInput3
		#if [ "yes"x == "$userInput3"x ]
		#then
		#	echo "开始提交配置数据....."
    #
		#	
		#	echo "结束读取配置数据....."
		#else
		#	echo "本次操作结束!"
		#fi
	else
		echo -e "服务器$MEM_HOST的缓存端口$cachePort存取数据异常，存入数据【$connector】，获取数据【$MEMCACHED_SET_AND_GET2】！\n"
	fi
else
	echo -e "服务器$MEM_HOST的缓存端口$cachePort存取数据异常，存入数据【$types】，获取数据【$MEMCACHED_SET_AND_GET】！\n"
fi



#if [ "a" == "$userInput" ] 
#then
#	echo "this is a"
#elif [ "a" == "$userInput" ]
#then
#	 echo "this is b"
#else
# echo "other"
#fi
