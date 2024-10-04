#!/bin/bash

#VMWare shared folder auto mount script v1.1
#https://github.com/HanBitz/vmhgfs_automount
#for DU System programming

#fstab path
PATH_FSTAB=/etc/fstab
#vmware shared folder path
PATH_MNT=/mnt/hgfs
#value for find installed when check fstab
VAL_HGFS="vmhgfs-fuse"

#check already installed
if [ `cat "$PATH_FSTAB" | grep -c "$VAL_HGFS"` -gt 0 ]; then
	echo "VM 공유폴더 자동 마운트가 이미 켜져있습니다."
else
	echo "VM hgfs 자동 마운트 설치중.."
	echo ""
	#check directory available
	if [ ! -d "$PATH_MNT" ]; then
		echo "경고! 공유폴더가 설정되지 않은 것 같습니다"
		echo "VMWare 공유폴더 설정을 먼저 해주세요.."
	else
		#write linux file volume list to auto mount vmware folder
		#name: vmhgfs-fuse, mount at: /mnt/hgfs, type: fuse(Filesystem in Userspace), [opt], no backup, no check filesystem at boot
		echo "vmhgfs-fuse   /mnt/hgfs    fuse    defaults,allow_other    0    0" >> /etc/fstab
		#check applied correctly
		if [ `cat "$PATH_FSTAB" | grep -c "$VAL_HGFS"` -gt 0 ]; then
			echo "설치 완료"
		else
			echo "설치 실패! 아래 내용과 함께 교수나 조교에게 문의해주세요.."
			echo ""
			echo "=== fstab ==="
			#show fstab elem without comments
			cat /etc/fstab | grep "^[^#;]" --color=never
			echo "============="
		fi
	fi
fi
echo ""
echo "설치 스크립트를 종료합니다."
