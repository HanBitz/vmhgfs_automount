#!/bin/bash

#VMWare shared folder auto mount script v1.11
#https://github.com/HanBitz/vmhgfs_automount
#for DU System programming
VAL_SC_VERSION=1.11

echo "VM Ware 공유폴더 자동 마운트 설치기 v$VAL_SC_VERSION"
echo ""

#check current user is not 0(root)
if [ `id -u` -ne 0 ]; then
	echo "설치를 위한 권한이 부족합니다, 루트 권한으로 실행해주세요.."
	echo "e.g. sudo ${0}"
else
	#permission ok

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
		#not installed, install now
		echo "VM hgfs 자동 마운트 설치중.."
		echo ""
		#check directory available
		if [ ! -d "$PATH_MNT" ]; then
			echo "경고! 공유폴더가 설정되지 않은 것으로 보입니다"
			echo "VMWare 공유폴더 설정을 먼저 해주세요.."
		else
			#write linux file volume list to auto mount vmware folder
			#name: vmhgfs-fuse(val), mount at: /mnt/hgfs(val), type: fuse(Filesystem in Userspace), [opt], no backup, no check filesystem at boot
			echo "$VAL_HGFS    $PATH_MNT    fuse    defaults,allow_other    0    0" >> $PATH_FSTAB
			#check applied correctly
			if [ `cat "$PATH_FSTAB" | grep -c "$VAL_HGFS"` -gt 0 ]; then
				echo "설치 완료"
			else
				#install failed
				echo "설치 실패! 아래 내용과 함께 조교에게 문의해주세요.."
				echo ""
				echo "=== fstab ==="
				#show fstab elem without comments, no color accent
				cat "$PATH_FSTAB" | grep "^[^#;]" --color=never
				echo "============="
			fi
		fi
	fi
fi
echo ""
echo "설치 스크립트를 종료합니다."
