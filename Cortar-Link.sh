#!/bin/bash
# GNU/Linux - ©WHITE HACKS 
# Edite by code - github.com/MRX90902WX
# GPL - General Public License
# Open Source - Software Libre
#
# ┌═══════════┐  ┌════════════┐
# █ Cortar-link █=>█ MRX90902WX █
# └═══════════┘  └════════════┘
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
Cyan="\033[0;36m"
Cafe="\033[0;33m"
Fiuscha="\033[0;35m"
blue="\033[1;34m"
nc="\e[0m"


#directory verification
directory=$(pwd)


if which figlet >/dev/null; then
sleep 1
echo ""
echo -e "$blue(figlet)$nc ................................................... Instalado [$green✓$nc]"
else
sleep 1
echo -e "$red(figlet)$nc No instalado [$red✗$nc]"
sleep 1
echo -e "\e[1;33mInstalando\e[0m \e[1;34mfiglet ...\e[0m"
sleep 3
setterm -foreground blue
pkg install figlet
fi

clear
# ===============================================
#                   VARIABLES
# ===============================================
PWD=$(pwd)
SYSTEM=$(uname -o)
HOME="/data/data/com.termux/files/home"
USR="/data/data/com.termux/files/usr"
# ===============================================
#               COLORES RESALTADOS
# ===============================================
negro="\e[1;30m"
azul="\e[1;34m"
verde="\e[1;32m"
cian="\e[1;36m"
rojo="\e[1;31m"
purpura="\e[1;35m"
amarillo="\e[1;33m"
blanco="\e[1;37m"
# ===============================================
#                 COLORES BAJOS
# ===============================================
black="\e[0;30m"
blue="\e[0;34m"
green="\e[0;32m"
cyan="\e[0;36m"
red="\e[0;31m"
purple="\e[0;35m"
yellow="\e[0;33m"
white="\e[0;37m"
# ===============================================
#            VERIFICANDO DEPENDENCIAS
# ===============================================
Dependencies(){
	if [ "${SYSTEM}" == "Android" ]; then
		if [ -x ${USR}/bin/curl ]; then
			PWD=$(pwd)
		else
			yes|pkg install curl
		fi
		if [ -x ${USR}/bin/urlspoof ]; then
			PWD=$(pwd)
		else
			echo -e "#!/bin/bash" >> ${USR}/bin/urlspoof
			echo -e "URLSpoof='${PWD}'" >> ${USR}/bin/urlspoof
			echo -e 'cd ${URLSpoof}' >> ${USR}/bin/urlspoof
			echo -e 'exec bash "${URLSpoof}/urlspoof.sh" "$@"' >> ${USR}/bin/urlspoof
			chmod 777 ${USR}/bin/urlspoof
		fi
	else
		if [ -x /bin/curl ]; then
			PWD=$(pwd)
		else
			echo -e "\ncurl: command not found"
			exit
		fi
		if [ -x /bin/urlspoof ]; then
			PWD=$(pwd)
		else
			echo -e "#!/bin/bash" >> /bin/urlspoof
			echo -e "URLSpoof='${PWD}'" >> /bin/urlspoof
			echo -e 'cd ${URLSpoof}' >> /bin/urlspoof
			echo -e 'exec bash "${URLSpoof}/urlspoof.sh" "$@"' >> /bin/urlspoof
			chmod 777 /bin/urlspoof
		fi
	fi
}
setterm -foreground red
echo "#######################################################"
setterm -foreground green
figlet Cortar-Link
setterm -foreground red
echo "#######################################################"
# ===============================================
#                SOLICITANDO URL
# ===============================================
echo -e -n "${negro}
┌═════════════════┐
█ ${cian}INGRESE UNA URL ${negro}█
└═════════════════┘
┃
└═>>> "${verde}
read -r URL
sleep 0.5
# ===============================================
#             PREGUNTANDO AL USUARIO
# ===============================================
Question(){
echo -e -n "${negro}
┌════════════════════════┐
█ ${cian}¿DESEA ACORTAR LA URL? ${negro}█
└════════════════════════┘
┃    ┌═══════════════════┐
└═>>>█ [${verde}01${negro}] ┃ ${azul}SI ACORTAR ${negro}█
┃    └═══════════════════┘
┃    ┌═══════════════════┐
└═>>>█ [${verde}02${negro}] ┃ ${azul}NO ACORTAR ${negro}█
┃    └═══════════════════┘
┃
└═>>> "${verde}
read -r QUESTION
# ===============================================
#          EJECUTANDO ACCIÓN DEL USUARIO
# ===============================================
if [[ "${QUESTION}" == "1" || "${QUESTION}" == "01" ]]; then
	SHORT=$(curl -s https://is.gd/create.php\?format\=simple\&url\=${URL})
	echo -e "${SHORT}" >> url.txt
	PROTOCOL=$(tail -n1 url.txt | cut -d "/" -f1)
	DOMAIN=$(tail -n1 url.txt | cut -d "/" -f4)
elif [[ "${QUESTION}" == "2" || "${QUESTION}" == "02" ]]; then
	sleep 0.5
	echo -e "${URL}" >> url.txt
	PROTOCOL=$(head -n1 url.txt | cut -d "/" -f1)
	DOMAIN=$(head -n1 url.txt | cut -d "/" -f3)
else
echo -e "${negro}
┌═══════════════════┐
█ ${rojo}OPCIÓN INCORRECTA ${negro}█
└═══════════════════┘
"${blanco}
	sleep 0.5
	URLSpoof
	Question
fi
}
# ===============================================
#      SUPLANTANDO URL CON INGENIERIA SOCIAL
# ===============================================
Spoofing(){
echo -e -n "${negro}
┌══════════════════════════════┐
█ ${cian}INGRESE PALABRAS PARA LA URL ${negro}█
└══════════════════════════════┘
┃
└═>>> "${verde}
read -r TEXT
sleep 0.5
WORDS=$(echo -e "${TEXT}" | tr ' ' '-')

if [[ "${QUESTION}" == "1" || "${QUESTION}" == "01" ]]; then
echo -e "${negro}
┌══════════════┐
█ ${verde}Cortar-Link ${negro}█
└══════════════┘
┃
└═>>>${blanco} ${PROTOCOL}//${WORDS}@is.gd/${DOMAIN}"
else
echo -e "${negro}
┌══════════════┐
█ ${verde}Cortar-Link ${negro}█
└══════════════┘
┃
└═>>>${blanco} ${PROTOCOL}//${WORDS}@${DOMAIN}"
fi
}
# ===============================================
#            GUARDANDO URL SPOOFING
# ===============================================
Save(){
if [[ "${QUESTION}" == "1" || "${QUESTION}" == "01" ]]; then
	rm url.txt
	echo -e "${URL} => ${PROTOCOL}//${WORDS}@is.gd/${DOMAIN}" >> Cortadolink.txt
else
	rm url.txt
	echo -e "${URL} => ${PROTOCOL}//${WORDS}@${DOMAIN}" >> Cortadolink.txt
fi
echo -e "${negro}
┌════════════════════════════┐
█ ${cian}URL GUARDADA EN EL ARCHIVO ${negro}█
└════════════════════════════┘
┃
└═>>>${verde} Cortadolink.txt
"${blanco}
}
# ===============================================
#              DECLARANDO FUNCIONES
# ===============================================
Dependencies
Question
Spoofing
Save
# ===============================================
#     Creado por Darkmux - WHITE HACKS ©2021
# ===============================================
