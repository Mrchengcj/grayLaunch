#!/bin/sh

pathPrefix="/tengine/system/nginx/conf/lua/exec/data/"
fileNames="userTypes.txt urls.txt phoneTypes.txt phoneNos.txt ips.txt change.txt brandTypes.txt areas.txt"

#for i in $fileNames
#do
#echo "读取文件:"$pathPrefix$i
#
#	for line in `cat $pathPrefix$i|tr -d "\n"`
#	do
#		echo "<$line>"
#	done
#done
#
#for i in $fileNames
#do
#	cacheValue=""
#	while read line; do
#		  cacheValue=$cacheValue$line"@"     
#		  echo "[$line]"
#	    echo "[$line]"|tr -d "\n"
#	done < $pathPrefix$i
#
#done

#for line in `cat /tengine/system/nginx/conf/lua/exec/data/urls.txt`
#	do
#		echo "<$line>"
#	done
#        
cacheIP="10.112.105.86"
cachePort="11211"
echo "开始缓存清空中。。。"                                                                                                 
#MEMCACHED_SET_AND_GET0x=`(sleep 1;echo "flush_all";sleep 1;) | telnet $cacheIP $cachePort |awk 'NR==1 {print $1}'`
MEMCACHED_SET_AND_GET0x=`(sleep 1;echo "flush_all";sleep 1;) | telnet $cacheIP $cachePort | awk 'NR==4 {print $1}'` 
echo "缓存清理结果=[$MEMCACHED_SET_AND_GET0x]"       
                                                    
if [ "$MEMCACHED_SET_AND_GET0x" = "OK" ]                                                                        
then                                                                                                              
echo -e "服务器$cacheIP的缓存端口$cachePort 清空缓存成功！\n"                                                              
else                                                                                                              
echo -e "服务器$cacheIP的缓存端口$cachePort存取数据异常，清空缓存失败！\n"                                                              
fi                                                                                                                