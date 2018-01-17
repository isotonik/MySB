#!/bin/bash 
# -----------------------------------------
if [ -f /etc/MySB/inc/includes_before ]; then source /etc/MySB/inc/includes_before; fi
# -----------------------------------------
#  __/\\\\____________/\\\\___________________/\\\\\\\\\\\____/\\\\\\\\\\\\\___        
#   _\/\\\\\\________/\\\\\\_________________/\\\/////////\\\_\/\\\/////////\\\_       
#    _\/\\\//\\\____/\\\//\\\____/\\\__/\\\__\//\\\______\///__\/\\\_______\/\\\_      
#     _\/\\\\///\\\/\\\/_\/\\\___\//\\\/\\\____\////\\\_________\/\\\\\\\\\\\\\\__     
#      _\/\\\__\///\\\/___\/\\\____\//\\\\\________\////\\\______\/\\\/////////\\\_    
#       _\/\\\____\///_____\/\\\_____\//\\\____________\////\\\___\/\\\_______\/\\\_   
#        _\/\\\_____________\/\\\__/\\_/\\\______/\\\______\//\\\__\/\\\_______\/\\\_  
#         _\/\\\_____________\/\\\_\//\\\\/______\///\\\\\\\\\\\/___\/\\\\\\\\\\\\\/__ 
#          _\///______________\///___\////__________\///////////_____\/////////////_____
#			By toulousain79 ---> https://github.com/toulousain79/
#
######################################################################
#
#	Copyright (c) 2013 toulousain79 (https://github.com/toulousain79/)
#	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#	--> Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
#
##################### FIRST LINE #####################################

if [ "`screen -ls | grep MySB`" == "" ]; then
	echo ""
	echo -e "${CRED}I am sorry, but you must start installation with$CEND ${CGREEN}MySB_Install.sh$CEND${CRED}, aborting!$CEND"
	exit 1
else
	if [ -f /etc/MySB/DEV ]; then
		GetString NO  "How do you want to start the script ? Type 'manual' or 'auto' ?" DevInstallMode "manual"
	fi
fi

#### Advertising
echo
echo -e "${CRED}############################################################$CEND"
echo -e "${CRED}#$CEND ${CYELLOW}At the end of the installation, you will receive an email.$CEND"
echo -e "${CRED}#$CEND ${CYELLOW}It lists information about your account.$CEND"
#echo -e "${CRED}#$CEND ${CYELLOW}A temporary password will be assigned to your account.$CEND"
#echo -e "${CRED}#$CEND ${CYELLOW}You will need to change it when receiving email.$CEND"
echo -e "${CRED}# IMPORTANT:$CEND ${CYELLOW}Remember to also check the SPAM folder...$CEND"
echo -e "${CRED}############################################################$CEND"
echo

echo
echo -e "${CRED}If you lose connection during installation, restart the SSH session and run the following command:$CEND"
echo -e "${CGREEN}	screen -r MySB$CEND"
echo -e "${CRED}Beware, during installation, the SSH port will be changed. If a port session 22 does not work, try with the new port that you have selected (maybe is 8892).$CEND"
echo

echo
echo -e "${CBLUE}When a user is added, it will receive a confirmation email.$CEND"
echo -e "${CBLUE}The new user must complete two additionnal steps.$CEND"
echo -e "${CGREEN}	1) Add its own public IP addresses "
echo -e "${CGREEN}	2) Change his password"
echo -e "${CRED}NB: The two stages will be noted in the email confirmation that the user will receive.$CEND"
echo
echo


echo -e "${CYELLOW}All is ok for start the install of MySB.$CEND"
echo
GetString NO  "Do you want to continue, type 'yes' ?" CONTINUE NO
if [ "$CONTINUE" == "NO" ]; then
	echo -e "${CYELLOW}OK, see you later...$CEND"
	echo
	echo
	EndingScript 0
else
	#### Create MySB banner
	if [ "$BANNER" == "ON" ]; then
		BannerGenerator
	fi	

	#### Advertising
	echo
	echo -e "${CRED}############################################################$CEND"
	echo -e "${CRED}#$CEND ${CYELLOW}At the end of the installation, you will receive an email.$CEND"
	echo -e "${CRED}#$CEND ${CYELLOW}It lists information about your account.$CEND"
#	echo -e "${CRED}#$CEND ${CYELLOW}A temporary password will be assigned to your account.$CEND"
#	echo -e "${CRED}#$CEND ${CYELLOW}You will need to change it when receiving email.$CEND"
	echo -e "${CRED}# IMPORTANT:$CEND ${CYELLOW}Remember to also check the SPAM folder...$CEND"
	echo -e "${CRED}############################################################$CEND"
	echo
	
	REBOOT=NO
fi	

if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}/bin/bash /etc/MySB/install/SourcesList$CEND"
	read -p "Press [Enter] key to continue..."
else
	#### 1 - sources.list
	echo -e -n "${CBLUE}Prepare Sources$CEND..."
	screen -dmS SourcesList /bin/bash /etc/MySB/install/SourcesList;
	WaitingScreen SourcesList
	StatusSTD
fi

if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Packages$CEND"
	read -p "Press [Enter] key to continue..."
else
	#### 2 - install all needed packages
	echo -e -n "${CBLUE}Install all needed packages$CEND..."
	screen -dmS Packages /bin/bash /etc/MySB/install/Packages;
	WaitingScreen Packages
	StatusSTD
fi

if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Tweaks$CEND"
	read -p "Press [Enter] key to continue..."
else
	#### 3 - Sytem tweaks
	echo -e -n "${CBLUE}Sytem optimization$CEND..."
	screen -dmS Tweaks /bin/bash /etc/MySB/install/Tweaks;
	WaitingScreen Tweaks
	StatusSTD
fi

if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/DownloadAll$CEND"
	read -p "Press [Enter] key to continue..."
else
	#### 3 - download all files now in one time (GIT, SVN, TAR.GZ, WBM)
	echo -e -n "${CBLUE}Download all files now in one time (GIT, SVN, TAR.GZ, WBM)$CEND..."
	screen -dmS DownloadAll /bin/bash /etc/MySB/install/DownloadAll;
	WaitingScreen DownloadAll
	StatusSTD
fi

if [ -f /etc/MySB/temp/continue ]; then
	echo ""
	echo -e "${CRED}Important files could not be downloaded, aborting !$CEND"
	echo
	cat /etc/MySB/temp/continue
	EndingScript 1
fi

if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Certificates 'CreateCACertificate'$CEND"
	read -p "Press [Enter] key to continue..."
else
	#### certificates
	echo -e -n "${CBLUE}Create certificates$CEND..."
	screen -dmS Certificates /bin/bash /etc/MySB/install/Certificates 'CreateCACertificate';
	WaitingScreen Certificates
	StatusSTD
fi

if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/SSH$CEND"
else
	#### SSH
	echo -e -n "${CBLUE}Install and configure SSH$CEND..."
	screen -dmS SSH /bin/bash /etc/MySB/install/SSH;
	WaitingScreen SSH
	StatusSTD
fi

#### postfix
if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Postfix$CEND"
	read -p "Press [Enter] key to continue..."
else
	echo -e -n "${CBLUE}Install and configure Postfix$CEND..."
	screen -dmS Postfix /bin/bash /etc/MySB/install/Postfix;
	WaitingScreen Postfix
	StatusSTD
fi

if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/PHP$CEND"
	read -p "Press [Enter] key to continue..."
else
	#### configure php5-fpm
	echo -e -n "${CBLUE}Install and configure PHP5-FPM$CEND..."
	screen -dmS PHP /bin/bash /etc/MySB/install/PHP;
	WaitingScreen PHP
	StatusSTD
fi

if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Nginx$CEND"
	read -p "Press [Enter] key to continue..."
else
	#### configure nginx
	echo -e -n "${CBLUE}Install and configure NginX$CEND..."
	screen -dmS Nginx /bin/bash /etc/MySB/install/Nginx;
	WaitingScreen Nginx
	StatusSTD
fi

#### vSFTPd
if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/VSFTP$CEND"
	read -p "Press [Enter] key to continue..."
else
	echo -e -n "${CBLUE}Install and configure VSFTPd$CEND..."
	screen -dmS VSFTP /bin/bash /etc/MySB/install/VSFTP;
	WaitingScreen VSFTP
	StatusSTD
fi

#### install rTorrent and depends
if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/rTorrent$CEND"
	read -p "Press [Enter] key to continue..."
else
	echo -e -n "${CBLUE}Install and configure rTorrent$CEND..."
	screen -dmS rTorrent /bin/bash /etc/MySB/install/rTorrent;
	WaitingScreen rTorrent
	StatusSTD
fi

#### install ruTorrent and plugins
if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/ruTorrent$CEND"
	read -p "Press [Enter] key to continue..."
else
	echo -e -n "${CBLUE}Install and configure ruTorrent & Plugins$CEND..."
	screen -dmS ruTorrent /bin/bash /etc/MySB/install/ruTorrent;
	WaitingScreen ruTorrent
	StatusSTD
fi

#### Tools for CakeBox and Seedbox-Manager
if [ "$INSTALLCAKEBOX" == "YES" ] || [ "$INSTALLMANAGER" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Tools$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure Composer, Bower and NodeJS$CEND..."
		screen -dmS Tools /bin/bash /etc/MySB/install/Tools;
		WaitingScreen Tools
		StatusSTD
	fi
fi

#### Seedbox-Manager
if [ "$INSTALLMANAGER" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/SeedboxManager$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure Seedbox-Manager$CEND..."
		screen -dmS SeedboxManager /bin/bash /etc/MySB/install/SeedboxManager;
		WaitingScreen SeedboxManager
		StatusSTD
	fi
fi

#### CakeBox Light
if [ "$INSTALLCAKEBOX" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/CakeboxLight$CEND"
		read -p "Press [Enter] key to continue..."
	else	
		echo -e -n "${CBLUE}Install and configure CakeBox Light$CEND..."
		screen -dmS CakeboxLight /bin/bash /etc/MySB/install/CakeboxLight;
		WaitingScreen CakeboxLight
		StatusSTD
	fi
fi

if [ "$INSTALLOPENVPN" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/OpenVPN \"server\"$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure OpenVPN$CEND..."
		screen -dmS OpenVPN /bin/bash /etc/MySB/install/OpenVPN "server";	
		WaitingScreen OpenVPN
		StatusSTD
	fi

	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Samba$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure Samba$CEND..."
		screen -dmS Samba /bin/bash /etc/MySB/install/Samba;	
		WaitingScreen Samba
		StatusSTD
	fi

	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/NFS$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure NFS$CEND..."
		screen -dmS NFS /bin/bash /etc/MySB/install/NFS;	
		WaitingScreen NFS
		StatusSTD
	fi
fi

#### fail2ban
if [ "$INSTALLFAIL2BAN" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Fail2Ban$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure Fail2Ban$CEND..."
		screen -dmS Fail2Ban /bin/bash /etc/MySB/install/Fail2Ban;
		WaitingScreen Fail2Ban
		StatusSTD
	fi
fi

#### Webmin
if [ "$INSTALLWEBMIN" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Webmin$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure Webmin$CEND..."
		screen -dmS Webmin /bin/bash /etc/MySB/install/Webmin;
		WaitingScreen Webmin
		StatusSTD
	fi
fi

#### Logwatch
if [ "$INSTALLLOGWATCH" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Logwatch$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure Logwatch$CEND..."
		screen -dmS Logwatch /bin/bash /etc/MySB/install/Logwatch;
		WaitingScreen Logwatch
		StatusSTD
	fi
fi

### PlexMedia
if [ "$INSTALLPLEXMEDIA" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/PlexMedia$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure PlexMedia$CEND..."
		screen -dmS PlexMedia /bin/bash /etc/MySB/install/PlexMedia;
		WaitingScreen PlexMedia
		StatusSTD
	fi
fi


#### BlockList
case $MYBLOCKLIST in
	PeerGuardian)
		if [ "$DevInstallMode" == "manual" ]; then
			clean
			echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/PeerGuardian$CEND"
			read -p "Press [Enter] key to continue..."
		else
			echo -e -n "${CBLUE}Install and configure PeerGuardian$CEND..."
			screen -dmS PeerGuardian /bin/bash /etc/MySB/install/PeerGuardian;		
			WaitingScreen PeerGuardian
			StatusSTD
		fi

		if [ "$DevInstallMode" == "manual" ]; then
			clean
			echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Blocklist$CEND"
			read -p "Press [Enter] key to continue..."
		else		
			echo -e -n "${CBLUE}Compile the BlockList for rTorrent$CEND..."
			screen -dmS Blocklist /bin/bash /etc/MySB/install/Blocklist;
			WaitingScreen Blocklist
			StatusSTD
		fi
	;;
	rTorrent)
		if [ "$DevInstallMode" == "manual" ]; then
			clean
			echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/Blocklist$CEND"
			read -p "Press [Enter] key to continue..."
		else
			echo -e -n "${CBLUE}Compile the BlockList for rTorrent$CEND..."
			screen -dmS Blocklist /bin/bash /etc/MySB/install/Blocklist;
			WaitingScreen Blocklist
			StatusSTD
		fi
	;;	
	*)
		echo -e -n "${CBLUE}Don't use any blocklist$CEND..."
		StatusSTD
	;;
esac

### DNScrypt-proxy
if [ "$INSTALLDNSCRYPT" == "YES" ]; then
	if [ "$DevInstallMode" == "manual" ]; then
		clean
		echo -e "${CGREEN}screen /bin/bash /etc/MySB/install/DNScrypt$CEND"
		read -p "Press [Enter] key to continue..."
	else
		echo -e -n "${CBLUE}Install and configure DNScrypt-proxy$CEND..."
		screen -dmS DNScrypt /bin/bash /etc/MySB/install/DNScrypt;
		WaitingScreen DNScrypt
		StatusSTD
	fi
fi

#### MySB_CreateUser
if [ "$DevInstallMode" == "manual" ]; then
	clean
	echo -e "${CGREEN}screen /bin/bash /etc/MySB/bin/MySB_CreateUser \"$NEWUSER\" \"$PASSWORD\" \"YES\" \"YES\"$CEND"
	read -p "Press [Enter] key to continue..."
else
	echo  -e -n "${CBLUE}Add the main user \"$NEWUSER\"$CEND..."
	screen -dmS MySB_CreateUser /bin/bash /etc/MySB/bin/MySB_CreateUser "$NEWUSER" "$PASSWORD" "YES" "YES";
	WaitingScreen MySB_CreateUser
	StatusSTD
fi

echo
echo -e "${CGREEN}Looks like everything is set.$CEND"
echo
echo -e "${CYELLOW}Remember that your SSH port is now ======>$CEND ${CBLUE}$NEWSSHPORT$CEND"
echo
echo -e "${CRED}System will reboot now, but don't close this window until you take note of the port number:$CEND ${CBLUE}$NEWSSHPORT$CEND"
echo
echo -e "${CBLUE}Available commands for your seedbox:$CEND"
echo -e "${CYELLOW}	User Management:$CEND"
echo -e "${CGREEN}			MySB_ChangeUserPassword$CEND"
echo -e "${CGREEN}			MySB_CreateUser$CEND"
echo -e "${CGREEN}			MySB_DeleteUser$CEND"
echo -e "${CYELLOW}	SeedBox Management:$CEND"
echo -e "${CGREEN}			MySB_RefreshMe$CEND"
echo -e "${CYELLOW}	MySB script Management:$CEND"
echo -e "${CGREEN}			MySB_UpdateGitHubRepo$CEND (update actual repository)"
echo -e "${CGREEN}			MySB_UpgradeMe$CEND (if new versions)"
echo
echo
echo -e "${CBLUE}You can check all informations for use your SeedBox here:$CEND"
echo -e "	-->	${CYELLOW}https://$HOSTFQDN:$NGINXHTTPSPORT/MySB/SeedboxInfo.php$CEND"

#### Reboot after install
if [ "$DevInstallMode" == "manual" ]; then
	GetString NO  "Do you want to reboot now, type 'yes' or 'no' ?" REBOOT NO
else
	REBOOT=YES
fi

# -----------------------------------------
if [ -f /etc/MySB/inc/includes_after ]; then source /etc/MySB/inc/includes_after; fi
# -----------------------------------------
##################### LAST LINE ######################################
