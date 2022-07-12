#!/bin/bash
LANG=en_US.UTF-8
    if [ $(whoami) != "root" ];then
	echo "请使用root权限执行本脚本!!!"
	exit 1;
	fi   //检测Root权限
    sleep 1s

    echo -e "\e[37m 你正在执行Centos7/8的Java自动安装脚本 \e[0m"
    sleep 1s
    echo -e "\e[37m 本脚本由Pysio制作,在Github开源 \e[0m"
    echo -e "\e[37m https://github.com/pysio2007/Minecraft_Server_Chinese/bash \e[0m"
    sleep 1s

    read -r -p "请输入y(确认)/n(取消)[Y/n]: " input

	case $input in
		[yY][eE][sS]|[yY])
			echo "Yes"
			;;

		[nN][oO]|[nN])
			echo "No"
			exit 1
			;;

		*)
			echo "请输入y(确认)/n(取消)"
			exit 1
			;;
	esac


    read -r -p "是否更换清华源请输入y(确认)/n(取消)[Y/n]: " input2
    case $input2 in
		[yY][eE][sS]|[yY])
			echo "Yes"
			read -r -p "请输入你的Centos版本[7/8]: " input3
			case $input3 in
				7)
				sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         			-e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
       				-i.bak \
       				/etc/yum.repos.d/CentOS-*.repo
					;;

				8)
				sed -e 's|^mirrorlist=|#mirrorlist=|g' \
       				-e 's|^#baseurl=http://mirror.centos.org/$contentdir|baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos|g' \
       				-i.bak \
         			/etc/yum.repos.d/CentOS-*.repo
					;;
				*)
				echo "请输入你的Centos版本[7/8]: "
				exit 1
					;;
			esac
			;;

		[nN][oO]|[nN])
			echo "No"
			break
			;;

		*)
			echo "请输入y(确认)/n(取消)"
			break
			;;
	esac

    echo -e	"\e[37m 现在开始更新软件源,这可能会需要一点儿时间！\0e[0m"
	sleep 3s
	yum makecache
	yum check-update -y;
	yum update -y;
	yum upgrade -y;

    echo -e	"\e[37m 软件源更新完成! 正在安装必要组件 \0e[0m"
	sleep 3s
	yum install screen git -y 
	
	echo -e	"\e[37m 安装完成,请选择需要安装的JAVA版本 \0e[0m"
	sleep 3s
	read -r -p "请输入需要安装的JAVA版本now为最新[8/11/now]: " javainstall

	case $javainstall in
		[Now][NOw][NOW]|[now])
			yum install java-latest-openjdk.x86_64 -y
			;;

		8)
			yum install java -y
			;;

		11)
			yum install java-11-openjdk.x86_64 -y
			;;

		*)
			echo "请输入需要安装的JAVA版本now为最新[8/11/now]"
			exit 1
			;;
	esac