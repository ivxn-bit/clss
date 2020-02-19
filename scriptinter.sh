#!/bin/bash

ok_msg() {
	echo Listo, volviendo al menu.
	sleep 2
}

while [ true ]
do

clear
echo 1. Activar conexion a los departamentos.
echo 2. Desactivar conexion departamentos.
echo 3. Bloquear paginas web.
echo 4. salir

read -p "que opcion eliges " opcion

case $opcion in
1)
echo 1. Diseño
echo 2. Programacion
echo 3. Ambas
read -p "A que departamento deseas activar la conexion? " departop
case $departop in
1)iptables -t nat -F
iptables -F
iptables -A INPUT -s 192.168.74.0/24 -i enp0s9 -j ACCEPT
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
ok_msg
;;
2)iptables -t nat -F
iptables -F
iptables -A INPUT -s 192.168.73.0/24 -i enp0s8 -j ACCEPT
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
ok_msg
;;
3)iptables -t nat -F
iptables -F
iptables -A INPUT -s 192.168.73.0/24 -i enp0s8 -j ACCEPT
iptables -A INPUT -s 192.168.74.0/24 -i enp0s9 -j ACCEPT
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
ok_msg
;;
*)echo Elige una de las opciones.
;;
esac
;;
2)iptables -F
iptables -t nat -F
ok_msg
;;
3)read -p "Que pagina web deseas bloquear? " pagbloq
iptables -A FORWARD -m string --string "$pagbloq" --algo bm -j DROP
iptables -A INPUT -m string --string "$pagbloq" --algo bm -j DROP
iptables -A OUTPUT -m string --string "$pagbloq" --algo bm -j DROP
ok_msg
;;
4)
exit ;;
*) echo elige un numero entre 1 y 4
esac
done 
