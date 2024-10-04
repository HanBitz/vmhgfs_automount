#!/bin/bash


value=`cat /etc/fstab`
cont_val="vmhgfs-fuse"
if [[ "$value" =~ "$cont_val" ]]; then
	echo "VM hgfs 자동 마운트가 이미 켜져있습니다."
else
	echo -e "VM hgfs 자동 마운트 설치중..\n"
	echo "vmhgfs-fuse   /mnt/hgfs    fuse    defaults,allow_other    0    0" >> /etc/fstab
	value=`cat /etc/fstab`
	if [[ "$value" =~ "$cont_val" ]]; then
		echo "설치 성공"
	else
		echo "설치 실패!"
	fi
fi
echo -e "\n쉘 스크립트를 종료합니다.\n\n"
