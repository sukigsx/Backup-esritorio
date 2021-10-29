#!/bin/bash

#colores
rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m" 
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores

#toma el control de control + c
trap ctrl_c INT
function ctrl_c()
{
clear
if [ -d /mnt/$nombre_destino ]
then
    clear
    echo -e "${amarillo} Existe unidad montada en la ruta /mnt/$nombre_destino ${borra_colores}"
    echo -e "${amarillo} Se procede a desmontar unidad y borrar la carpeta temporal con orden sudo umount.${borra_colores}"
    sudo umount /mnt/$nombre_destino 2>/dev/null
    sudo rmdir /mnt/$nombre_destino 2>/dev/null
    clear
    figlet -c Gracias por 
    figlet -c utilizar mi
    figlet -c script
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    exit
else
    clear
    figlet -c Gracias por 
    figlet -c utilizar mi
    figlet -c script
    wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz
    exit
fi
}

#comprueba si esta el fichero de configuracion, si esta continua, de lo contrario configura el fichero.
if [ -f config_backup-escritorio ]
then
    echo -e ""
else
    while :
    do
    clear
    echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
    echo -e "${verde}  Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
    echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
    echo ""
    echo -e "${verde} Nombre del script --> backup-escritorio.sukigsx.sh ${borra_colores}"
    echo ""
    echo -e "${verde} Descripcion.${borra_colores} Copia/restaura la configuracion de tu escritorio."
    echo ""
    echo -e " Menu de configuracion del script."
    echo -e ""
    echo -e "  0.${azul} Actualizar el script.${borra_colores}"
    echo -e ""
    echo -e "  1.${azul} Configuracion en ${amarillo}red.${borra_colores}."
    echo -e "  2.${azul} Configuracion en ${amarillo}local.${borra_colores}"
    echo ""
    echo -e "  3.${azul} Manual de ayuda.${borra_colores}"
    echo ""
    echo -e " 99.${azul} Atras / Salir.${borra_colores}"
    echo ""
    echo -n " Selecciona una opcion -->> "
    read opcion
    case $opcion in
    
    1)  #Configuracion en red
        echo -e " red"
        ;;
    
    2)  #configuracion en local
        echo -e " local"
        ;;
        
    90) #ayuda
        echo -e " ayuda"
        ;;
        
    99) #salir
        echo -e " salir"
        ;;
    
    *)  
        echo ""
        echo -e "${rojo} Opcion No disponible en el menu principal.....${borra_colores}"
        echo -e "${amarillo} Pulsa una tecla para continuar o ( control + c ) salir.${borra_colores}"
        read pause;;
    esac
    done
fi
