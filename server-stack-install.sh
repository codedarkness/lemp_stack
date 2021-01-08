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
#        FILE: stack-server-install.sh
#       USAGE: ./stack-server-install.sh
#
# DESCRIPTION: Install lamp or lemp stack for live server
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 01-07-21
#
# -----------------------------------------------------------------

update-server() {
	echo ""
	echo " Update/Upgrade Sistem"
	echo ""
	sleep 2

	sudo apt update && sudo apt upgrade &&
	echo " Your sistem is update" || echo " There is a problen in the matrix!"
	echo ""
}

lamp-stack() {
	config-files/lamp-stack.sh
}

lemp-stack() {
	config-files/lemp-stack.sh
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
	echo "   _____                          _____ _             _     "
	echo "  / ____|                        / ____| |           | |    "
	echo " | (___   ___ _ ____   _____ _ _| (___ | |_ __ _  ___| | __ "
	echo "  \___ \ / _ \ '__\ \ / / _ \ '__\___ \| __/ _' |/ __| |/ / "
	echo "  ____) |  __/ |   \ V /  __/ |  ____) | || (_| | (__|   <  "
	echo " |_____/ \___|_|    \_/ \___|_| |_____/ \__\__,_|\___|_|\_\ "
	echo ""
	echo " Install LAPM or LEMP Stack for Debian - Ubuntu"
	echo ""
	echo " 1 - Update Sever"
	echo " 2 - LAMP Stack"
	echo " 3 - LEMP Stack"
	echo " 0 - Exit"
	echo ""
	echo -n " Enter selection [1 - 0] : "
	read selection
	echo ""

	case $selection in
		1) clear; update-server  ; press_enter ;;
		2) clear; lamp-stack    ;;
		3) clear; lemp-stack    ;;
		0) clear; exit ;;
		*) clear; incorrect_selection ; press_enter ;;
	esac
done
