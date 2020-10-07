#!/bin/sh
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software Foundation,
#  Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA

if [ "$1" = "uninstall" ]; then
	rm -f /etc/xdg/autostart/sparky-conky.desktop
	rm -f /opt/conky/conky-sparky.conf
	rm -f /opt/conky/week.sh
	rm -f /usr/bin/sparky-conky
	rm -f /usr/lib/sparkycenter/look/sparky-conky.desktop
	rm -f /usr/share/applications/sparky-conky.desktop
	rm -f /usr/share/menu/sparky-conky
	rm -rf /usr/share/sparky/sparky-conky
else
	# preinstall
	if [ -f /opt/conky/conky-sparky.conf ]; then
		cp /opt/conky/conky-sparky.conf /opt/conky/conky-sparky.conf.bak
	fi

	# install
	cp etc/* /etc/xdg/autostart/
	if [ ! -d /opt/conky ]; then
		mkdir -p /opt/conky
	fi
	cp opt/* /opt/conky/
	cp bin/* /usr/bin/
	if [ ! -d /usr/lib/sparkycenter/look ]; then
		mkdir -p /usr/lib/sparkycenter/look
	fi
	cp share/sparky-conky.desktop /usr/lib/sparkycenter/look/
	cp share/sparky-conky.desktop /usr/share/applications/
	cp share/sparky-conky /usr/share/menu/
	if [ ! -d /usr/share/sparky/sparky-conky ]; then
		mkdir -p /usr/share/sparky/sparky-conky
	fi
	cp lang/* /usr/share/sparky/sparky-conky/

	# postinstall
	USER1000=`cat /etc/passwd | grep 1000 | awk -F: '{ print $1 }'`
	USER1001=`cat /etc/passwd | grep 1001 | awk -F: '{ print $1 }'`
	USER1002=`cat /etc/passwd | grep 1002 | awk -F: '{ print $1 }'`

	if [ "$USER1000" != " " ]; then 
		chown -R $USER1000:$USER1000 /opt/conky
	elif [ "$USER1001" != " " ]; then 
		chown -R $USER1001:$USER1001 /opt/conky
	elif [ "$USER1002" != " " ]; then 
		chown -R $USER1002:$USER1002 /opt/conky
	fi

	if [ -x "`which update-menus 2>/dev/null`" ]; then
		update-menus
	fi
fi
