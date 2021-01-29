#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.xyz
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: lemp-stack-install.sh
#       USAGE: ./lemp-stack-install.sh
#
# DESCRIPTION: Instal lemp stack in debian or ubuntu server
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 01-07-08:18
#
# -----------------------------------------------------------------

install-nginx() {
	echo ""
	echo " Installing NGINX"
	echo ""
	sleep 2

	## Install nginx and certbot
	PKGS=(nginx
	certbot)

	sudo apt install -y "${PKGS[@]}" &&
	echo " nginx and certbot where installed" | echo " We have a problem!"
	echo ""

	## Install for debian or ubuntu
	echo " the server needs another program to work with certbot: "
	echo " python-certbot-nginx is the name for debian"
	echo " python3-certbot-nginx is the name for Ubuntu"
	echo " Select the correct program to install in your server"
	echo ""

	while true; do
		read -p " Is a Debian Server [ y - n ] : " yn
		case $yn in
			[Yy]* )
				sudo apt install python-certbot-nginx -y; break ;;
			[Nn]* )
				break ;;
			* ) echo " Please answer yes or no." ;;
		esac
	done
	echo ""

	while true; do
		read -p " Is a Ubuntu Server [ y - n ] : " yn
		case $yn in
			[Yy]* )
				sudo apt install python3-certbot-nginx -y; break ;;
			[Nn]* )
				break ;;
			* ) echo " Please answer yes or no." ;;
		esac
	done
	echo ""

	## nginx server block
	echo " Create the new server block for the website"
	echo " A directory will be create at /var/www/ whit the domain name"
	echo " and it will create a new server block in sites-avaiable and it will"
	echo " enable in sites-enabled"
	echo ""

	read -p " Which is the domain name (mydomian.xxx) : " choice;
	sudo mkdir /var/www/$choice &&
	cp configs/nginx_html configs/$choice &&
	sed -i 's/domain.xxx/'$choice'/g' configs/$choice &&
	sed -i 's/www.domain.xxx/www.'$choice'/g' configs/$choice &&
	sed -i 's/domain/'$choice'/g' configs/$choice &&
	sudo cp configs/$choice /etc/nginx/sites-available/ &&
	sudo ln -s /etc/nginx/sites-available/$choice /etc/nginx/sites-enabled/ &&
	sudo systemctl reload nginx &&
	echo " Everything is setup for new domain $choice" || echo " Huston we have a problem!"
	echo ""

	echo " Everything is setup for your new web site, now if you are in a live server"
	echo " run certbot for you ssl certificate"
	echo ""
}

install-lemp() {
	echo ""
	echo " Installing LEMP Stack"
	echo ""
	sleep 2

	## Install nginx and certbot
	PKGS=(nginx
	certbot
	mariadb-server
	php-fpm
	php-mysql
	php-intl
	php-mbstring
	php-zip
	php-xml)

	sudo apt install -y "${PKGS[@]}" &&
	echo " LEMP Stack where installed" | echo " We have a problem!"
	echo ""

	## Install for debian or ubuntu
	echo " the server needs another program to work with certbot: "
	echo " python-certbot-nginx is the name for debian"
	echo " python3-certbot-nginx is the name for Ubuntu"
	echo " Select the correct program to install in your server"
	echo ""

	while true; do
		read -p " Is a Debian Server [ y - n ] : " yn
		case $yn in
			[Yy]* )
				sudo apt install python-certbot-nginx -y; break ;;
			[Nn]* )
				break ;;
			* ) echo " Please answer yes or no." ;;
		esac
	done
	echo ""

	while true; do
		read -p " Is a Ubuntu Server [ y - n ] : " yn
		case $yn in
			[Yy]* )
				sudo apt install python3-certbot-nginx -y; break;;
			[Nn]* )
				break ;;
			* ) echo " Please answer yes or no." ;;
		esac
	done
	echo ""

	## nginx server block
	echo " Create the new server block for the website"
	echo " A directory will be create at /var/www/ whit the domain name"
	echo " and it will create a new server block in sites-avaiable and it will"
	echo " enable in sites-enabled"
	echo ""

	read -p " Which is the domain name : " choice;
	sudo mkdir /var/www/$choice &&
	cp configs/nginx_php configs/$choice &&
	sed -i 's/domain.xxx/'$choice'/g' configs/$choice &&
	sed -i 's/www.domain.xxx/www.'$choice'/g' configs/$choice &&
	sed -i 's/domain/'$choice'/g' configs/$choice &&
	sudo cp configs/$choice /etc/nginx/sites-available/ &&
	sudo ln -s /etc/nginx/sites-available/$choice /etc/nginx/sites-enabled/ &&
	sudo systemctl reload nginx &&
	echo " Everything is setup for new domain $choice" || echo " Huston we have a problem!"
	echo ""

	echo " Everything is setup for your new php web site, now if you are in a live server"
	echo " run certbot for you ssl certificate"
	echo ""
}

phpmyadmin-ubuntu() {
	echo ""
	echo " PhpMyAdmin for Ubuntu Server"
	echo ""
	sleep 2

	## Install phpmyadmin in ubuntu server
	sudo apt install phpmyadmin -y &&
	echo " PhpMyAdmin were installed" || echo " There is problem!!!"
	echo ""

	## Setup phpmyadmin to work with nginx
	echo " You need to create a sub-domain name to work with phpmyadmin and nginx"
	echo " Also make sure you have a cname for the sub-domain in your domain provider and"
	echo " re-directed to your server, this is for a VPS or a server with a public ip address"
	echo ""

	read -p " Which is the sub-domain name (myadmin.mydomain.xxx) : " choice;
	cp configs/phpmyadmin configs/phpmyadmin.conf &&
	sed -i 's/domain.xxx/'$choice'/g' configs/phpmyadmin.conf &&
	sudo cp configs/phpmyadmin.conf /etc/nginx/conf.d/ &&
	sudo systemctl reload nginx &&
	echo " Everything is setup for new phpmyadmin domain $choice" || echo " Huston we have a problem!"
	echo ""

	echo " Everything is setup for phpmyadmin"
	echo ""
}

run-certbot() {
	echo ""
	echo " Certbot"
	echo ""
	sleep 2

	## Certbot
	echo " Certbot will get the SSL certificate for the website(s)"
	echo " Follow the instructions to get the certificate"
	echo " Make sure that you setup already the cnames in you domain provider and the domain"
	echo " is re-direct to your server, this is for a VPS or a server with a public ip address"
	echo ""

	while true; do
		read -p " Run certbot [ y - n ] : " yn
		case $yn in
			[Yy]* )
				certbot --nginx; break ;;
			[Nn]* )
				break ;;
			* ) echo " Please answer yes or no." ;;
		esac
	done
	echo ""
}

create-nginx-web() {
	echo ""
	echo " Create a new nginx website htlm/php"
	echo ""
	sleep 2

	while true; do
		read -p "HTML Website [ y - n ] : " yn
		case $yn in
			[Yy]* )
				read -p " Which is the domain name (mydomain.xxx) : " choice;
				sudo mkdir /var/www/$choice &&
				cp configs/nginx_html configs/$choice &&
				sed -i 's/domain.xxx/'$choice'/g' configs/$choice &&
				sed -i 's/www.domain.xxx/www.'$choice'/g' configs/$choice &&
				sed -i 's/domain/'$choice'/g' configs/$choice &&
				sudo cp configs/$choice /etc/nginx/sites-available/ &&
				sudo ln -s /etc/nginx/sites-available/$choice /etc/nginx/sites-enabled/ &&
				sudo systemctl reload nginx &&
				echo " Everything is setup for new domain $choice" || echo " Huston we have a problem!"
				echo ""; break ;;
			[Nn]* )
				break ;;
			* ) echo " Please answer yes or no." ;;
		esac
	done
	echo ""

	while true; do
		read -p " PHP/HTML Website [ y - n ] : " yn
		case $yn in
			[Yy]* )
				read -p " Which is the domain name (mydomain.xxx) : " choice;
				sudo mkdir /var/www/$choice &&
				cp configs/nginx_php configs/$choice &&
				sed -i 's/domain.xxx/'$choice'/g' configs/$choice &&
				sed -i 's/www.domain.xxx/www.'$choice'/g' configs/$choice &&
				sed -i 's/domain/'$choice'/g' configs/$choice &&
				sudo cp configs/$choice /etc/nginx/sites-available/ &&
				sudo ln -s /etc/nginx/sites-available/$choice /etc/nginx/sites-enabled/ &&
				sudo systemctl reload nginx &&
				echo " Everything is setup for new domain $choice" || echo " Huston we have a problem!"
				echo ""; break ;;
			[Nn]* )
				break ;;
			* ) echo " Please answer yes or no." ;;
		esac
	done
	echo ""
}

press_enter() {
	echo ""
	echo -n " Press Enter To Continue"
	read
	clear
}

incorrect_selection() {
	echo " Incorrect selection! try again"
}

until [ "$selection" = "0" ]; do
	clear
	echo ""
	echo " DarknessCode"
	echo "  _      ______ __  __ _____     _             _     "
	echo " | |    |  ____|  \/  |  __ \   | |           | |    "
	echo " | |    | |__  | \  / | |__) |__| |_ __ _  ___| | __ "
	echo " | |    |  __| | |\/| |  ___/ __| __/ _' |/ __| |/ / "
	echo " | |____| |____| |  | | |   \__ \ || (_| | (__|   <  "
	echo " |______|______|_|  |_|_|   |___/\__\__,_|\___|_|\_\ "
	echo ""
	echo " Install LEMP Stack in Debian and Ubuntu Server"
	echo ""
	echo " 1 - nginx for html only"
	echo " 2 - Stack (nginx, MySQL, PHP)"
	echo " 3 - PhpMyAdmin (for Ubunut only)"
	echo ""
	echo " 4 - Run Certbot (SSL Cetificate)"
	echo " 5 - Create nginx block"
	echo ""
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; install-nginx     ; press_enter ;;
		2) clear; install-lemp      ; press_enter ;;
		3) clear; phpmyadmin-ubuntu ; press_enter ;;
		4) clear; run-certbot       ; press_enter ;;
		5) clear; create-nginx-web  ; press_enter ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
