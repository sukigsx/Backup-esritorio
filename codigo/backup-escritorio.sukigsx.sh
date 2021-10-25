#!/bin/bash

#colores
#forma de utilizar los colores en echo
#echo -e "${rojo}Estes es el texto en rojo.${borra_colores"
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

clear 
echo ""
echo -e "${amarillo} Comprobando software necesario.${borra_colores}"
echo ""

## Vericica conexion a internet
if ping -c1 google.com &>/dev/null;
then
    echo -e "- [${verde}ok${borra_colores}] Conexion a internet."
else
    clear
    echo ""
    echo -e "${rojo} NO se ha detectado conexion a internet, No se puede ejecutar el script.${borra_colores}"
    echo -e "${rojo} Pulsa una tecla para continuar.${borra_colores}"
    echo ""
    read pasue
    exit
fi

## verificar software necesario
## wmctrl, para el control del tamaño del terminal
which wmctrl 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
wmctrl=$? #recojemos el 0 o 1 del resultado de which
contador="1" #ponemos la variable contador a 1
while [ $wmctrl -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
do
    if [ $contador = "4" ] #si el contador es 4 entre en then y sino en else
    then #si entra en then es porque el contador es igual a 4 y no ha podido instalar
        echo ""
        echo -e " ${rojo}NO se ha podido instalar (wmctrl), para el control de la pantalla del terminal."
        echo -e " Intentelo usted con la orden sudo ${amarillo}sudo apt install wmctrl${rojo}"
        echo -e " No se puede ejecutar el script.${borra_colores}"
        echo ""
        exit
    else #intenta instalar
        sudo apt install wmctrl -y 2>/dev/null 1>/dev/null 0>/dev/null
        let "contador=contador+1" #incrementa la variable contador en 1
        which wmctrl 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
        wmctrl=$? ##recojemos el 0 o 1 del resultado de which
    fi
done
echo -e "- [${verde}ok${borra_colores}] wmctrl, Control de pantalla."

## figlet, para los baners
which figlet 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
figlet=$? #recojemos el 0 o 1 del resultado de which
contador="1" #ponemos la variable contador a 1
while [ $figlet -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
do
    if [ $contador = "4" ] #si el contador es 4 entre en then y sino en else
    then #si entra en then es porque el contador es igual a 4 y no ha podido instalar
        echo ""
        echo -e " ${rojo}NO se ha podido instalar (figlet), para los baners del script."
        echo -e " Intentelo usted con la orden sudo ${amarillo}sudo apt install figlet${rojo}"
        echo -e " No se puede ejecutar el script.${borra_colores}"
        echo ""
        exit
    else #intenta instalar
        sudo apt install figlet -y 2>/dev/null 1>/dev/null 0>/dev/null
        let "contador=contador+1" #incrementa la variable contador en 1
        which figlet 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
        figlet=$? ##recojemos el 0 o 1 del resultado de which
    fi
done
echo -e "- [${verde}ok${borra_colores}] figlet, Baners de terminal."

# smbclient, para la restauracion
which smbclient 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
smbclient=$? #recojemos el 0 o 1 del resultado de which
contador="1" #ponemos la variable contador a 1
while [ $smbclient -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
do
    if [ $contador = "4" ] #si el contador es 4 entre en then y sino en else
    then #si entra en then es porque el contador es igual a 4 y no ha podido instalar
        echo ""
        echo -e " ${rojo}NO se ha podido instalar (smbclient), para la restauracion en red."
        echo -e " Intentelo usted con la orden sudo ${amarillo}sudo apt install figlet${rojo}"
        echo -e " No se puede ejecutar el script.${borra_colores}"
        echo ""
        exit
    else #intenta instalar
        sudo apt install smbclient -y 2>/dev/null 1>/dev/null 0>/dev/null
        let "contador=contador+1" #incrementa la variable contador en 1
        which smbclient 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
        smbclient=$? ##recojemos el 0 o 1 del resultado de which
    fi
done
echo -e "- [${verde}ok${borra_colores}] smbclient, Para la restauracion en red."

# cifs-utils, para el montaje de la unidad con mount
which cifscreds 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
cifscreds=$? #recojemos el 0 o 1 del resultado de which
contador="1" #ponemos la variable contador a 1
while [ $cifscreds -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
do
    if [ $contador = "4" ] #si el contador es 4 entre en then y sino en else
    then #si entra en then es porque el contador es igual a 4 y no ha podido instalar
        echo ""
        echo -e " ${rojo}NO se ha podido instalar (cifscreds), para montar la unidad en red."
        echo -e " Intentelo usted con la orden sudo ${amarillo}sudo apt install figlet${rojo}"
        echo -e " No se puede ejecutar el script.${borra_colores}"
        echo ""
        exit
    else #intenta instalar
        sudo apt install cifs-utils -y 2>/dev/null 1>/dev/null 0>/dev/null
        let "contador=contador+1" #incrementa la variable contador en 1
        which cifscreds 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
        cifscreds=$? ##recojemos el 0 o 1 del resultado de which
    fi
done
echo -e "- [${verde}ok${borra_colores}] cifscreds (cifs-utils), Para montar la unidad en red."


## diff, comando de comparar
which diff 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
diff=$? #recojemos el 0 o 1 del resultado de which
contador="1" #ponemos la variable contador a 1
while [ $diff -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
do
    if [ $contador = "4" ] #si el contador es 4 entre en then y sino en else
    then #si entra en then es porque el contador es igual a 4 y no ha podido instalar
        echo ""
        echo -e " ${rojo}NO se ha podido instalar (diff), para comparacion de ficheros."
        echo -e " Intentelo usted con la orden sudo ${amarillo}sudo apt install diff${rojo}"
        echo -e " No se puede ejecutar el script.${borra_colores}"
        echo ""
        exit
    else #intenta instalar
        sudo apt install diff -y 2>/dev/null 1>/dev/null 0>/dev/null
        let "contador=contador+1" #incrementa la variable contador en 1
        which diff 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
        diff=$? ##recojemos el 0 o 1 del resultado de which
    fi
done
echo -e "- [${verde}ok${borra_colores}] diff, Para comprara ficheros."

#comprueba aztualiczacion del script



echo ""
echo -e " ${verde}Todo el software correcto.${borra_colores}"
sleep 3


#empieza lo gordo
ruta_destino="VALOR REQUERIDO"
unidad_red="VALOR NO REQUERIDO"

#ruta_destino=VARIABLE_VACIAS

#variable de nombre de usuario del sistema cargado
usuario=$(whoami)
#variable de hostname del sistema cargado
maquina=$(hostname)
#variable nombre destino
nombre_destino="No Montado"

while :
do
#maximiza la terminal.
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
clear
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
echo -e "${verde}  Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
echo ""
echo -e "${verde} Nombre del script --> backup-escritorio.sukigsx.sh ${borra_colores}"
echo ""
echo -e "${verde} Descripcion.${borra_colores} Copia/restaura la configuracion de tu escritorio."
echo ""
echo -e "${amarillo} Por seguridad la carpeta destino en local, la tiene que crear el usuario."
echo -e " Si es una carpeta/directorio de red, tendras que montarla en tu sistema, Opcion ( 5 ).${borra_colores}"
echo ""
echo -e "  0.${azul} Actualizar el script.${borra_colores}"
echo ""
echo -e "  1.${azul} Introduce la ruta abosoluta de las copias de seguridad. ( Ruta seleccionada -->> ${rojo}$ruta_destino${borra_colores} )."
echo ""
echo -e "  2.${azul} Listar las copias que tienes en el servidor.${borra_colores}"
echo -e "  3.${azul} Backup (Se eliminara el backup anterior).${borra_colores}"
echo -e "  4.${azul} Restaurar (Se restaura encima del que tienes).${borra_colores}"
echo -e "  5.${azul} Borra un Backup.${borra_colores}"
echo ""
echo -e "  6.${azul} Montar unidad de red, de forma temporal. (${verde} $unidad_red montado en /mnt/$nombre_destino${borra_colores})"
echo ""
echo -e "  7.${azul} Manual de ayuda.${borra_colores}"
echo ""
echo -e " 99.${azul} Atras / Salir.${borra_colores}"
echo ""
echo -n " Selecciona una opcion -->> "
read opcion
case $opcion in

    0)  #actualiza el script
        if [ -e /usr/bin/backup-escritorio.sukigsx.sh ] #comprueba si se ha instalado el script con el deb, comprobando el fichero /usr/bin/inicio.ocamlfuse.sh
        then
            ruta="/usr/bin"
            cd /tmp
            mkdir temporal_update
            git clone https://github.com/sukigsx/Backup-esritorio.git /tmp/temporal_update
            cd /tmp/temporal_update/codigo/
            sudo chmod +x $ruta/*.sukigsx.sh
            sudo cp -r /tmp/temporal_update/codigo/* $ruta
            sudo rm -r /tmp/temporal_update
            clear
            echo "";
            echo -e "${verde} Script actualizado, tienes que reiniciar el script para ver los cambios.${borra_colores}";
            echo "";
            ctrl_c;
        else
            ruta=$(pwd)
            cd /tmp
            mkdir temporal_update
            git clone https://github.com/sukigsx/Backup-esritorio.git /tmp/temporal_update
            cd /tmp/temporal_update/codigo/
            sudo chmod +x $ruta/*.sukigsx.sh
            sudo cp -r /tmp/temporal_update/codigo/* $ruta
            sudo rm -r /tmp/temporal_update
            clear
            echo "";
            echo -e "${verde} Script actualizado, tienes que reiniciar el script para ver los cambios.${borra_colores}";
            echo "";
            ctrl_c;
        fi;;

    1)  #se introduce la variable ruta_detino
        read -p " Dime la ruta destino -->> " ruta_destino;
            if [[ -d $ruta_destino && !$ruta_destino ]];
            then
                echo ""
                echo -e " Ruta destino -->>${verde} $ruta_destino ${borra_colores}";
                echo -e " Usuario ------->>${verde} $usuario ${borra_colores}";
                echo -e " Maquina ------->>${verde} $maquina ${borra_colores}";
                echo ""
                read -p " Es correcto (S/N) -->> " correcto;
                    if [[ $correcto = "S" || $correcto = "s" ]]
                        then 
                            #la ruta destino el usuario marca correcta, sigue el script
                            echo "";
                        else
                            clear
                            echo -e " ${amarillo}Ruta destino erronea o se ha borrado, ingresa de nuevo la nueva ruta.${borra_colores}";
                            echo "";
                            ruta_destino="VALOR REQUERIDO";
                            echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                            read pause;
                    fi;
            else
                clear
                echo "";
                echo -e " ${amarillo}La carpeta/directorio${rojo} $ruta_destino${amarillo}.${rojo} NO EXISTE${borra_colores}";
                echo -e " ${amarillo}Si la ruta es local, creala y ejecuta el script de nuevo.${borra_colores}";
                echo -e " ${amarillo}Si la ruta es de red, posiblemente no ete montada la unidad.${borra_colores}";
                echo "";
                ruta_destino="VALOR REQUERIDO"
                echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                read pause;
            fi;;
    2) #lista el contenido de ruta_destino
        if [ $ruta_destino ] 2>/dev/null;
        then
            if [ -d $ruta_destino ];
            then
                clear;
                echo -e "${verde} Lista de respaldos en $ruta_destino.${borra_colores}";
                echo -e "${amarillo}"
                ls -l $ruta_destino | awk '{print $9}';
                echo -e "${borra_colores}"
                echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                read pausa;
            else
                clear 
                echo ""
                echo "${amarillo} La ruta destino ${rojo}$ruta_destino${amarillo} no esta disponible";
                echo ""
                echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                read pausa;
            fi;
        else
            clear
            echo ""
            echo -e "  ${amarillo}LA RUTA DE DESTINO NO ESTA DEFINIDA. Selecciona la opcion ( 1 ), para indicarla.${borra_colores}";
            echo ""
            echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
            read pause;
        fi;;

    3)  #realiza la copia de seguridad
        if [ $ruta_destino ] 2>/dev/null
        then
            if [ -d $ruta_destino ] 2>/dev/null
            then
                sudo rm -r $ruta_destino/$maquina"_de_"$usuario/ 2>/dev/null
                echo "";
                echo -e " ${amarillo}Realizando la copia de segirudad ...  Espera unos segundos ...${borra_colores}"
                echo "";
                
                #crea los directorios y copia lo necesario
                mkdir -p $ruta_destino/$maquina"_de_"$usuario/{applications,menus,escritorio,plasma_icons} 0>/dev/null 1>/dev/null 2>/dev/null
                cp -r /home/$(whoami)/.local/share/applications/* $ruta_destino/$maquina"_de_"$usuario/applications/ 0>/dev/null 1>/dev/null 2>/dev/null
                cp -r /home/$(whoami)/.config/menus/* $ruta_destino/$maquina"_de_"$usuario/menus/ 0>/dev/null 1>/dev/null 2>/dev/null
                cp -r /home/$(whoami)/.local/share/plasma_icons/* $ruta_destino/$maquina"_de_"$usuario/plasma_icons/ 0>/dev/null 1>/dev/null 2>/dev/null
                cp -r /home/$(whoami)/.config/k* $ruta_destino/$maquina"_de_"$usuario/escritorio/ 0>/dev/null 1>/dev/null 2>/dev/null
                cp -r /home/$(whoami)/.config/plasma* $ruta_destino/$maquina"_de_"$usuario/escritorio/ 0>/dev/null 1>/dev/null 2>/dev/null
                
                echo -e "  ${amarillo}Todo copiado en $ruta_destino ${borra_colores}";
                echo ""
                echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                read pausa;
                clear;
            else
                clear
                echo "";
                echo -e " ${amarillo}La carpeta/directorio${rojo} $ruta_destino${amarillo}.${rojo} NO EXISTE${borra_colores}";
                echo -e " ${amarillo}Si la ruta es local, creala y ejecuta el script de nuevo.${borra_colores}";
                echo -e " ${amarillo}Si la ruta es de red, posiblemente no ete montada la unidad.${borra_colores}";
                echo "";
                ruta_destino="VALOR REQUERIDO"
                echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                read pause;
            fi;
        else
            clear
            echo "";
            echo -e " ${amarillo}LA RUTA DE DESTINO NO ESTA DEFINIDA. Selecciona la opcion ( 1 ), para indicarla.${borra_colores}";
            echo "";
            echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
            read pause;
        fi;;
        
    4)  #restauracion de copia seleccionada
        if [ $ruta_destino ] 2>/dev/null
        then
            if [ -d $ruta_destino/$maquina"_de_"$usuario ] 2>/dev/null
            then
                clear
                echo ""
                echo -e "${amarillo} Restauracion de $ruta_destino/$maquina"_de_"$usuario/";
                echo -e " En /home/$usuario/";
                echo -e "${borra_colores}"
                read -p " Es correcto ( S/N ) ? -->> " correcto;
                if [[ $correcto = "S" || $correcto = "s" ]];
                then 
                    echo ""
                    echo -e " ${amarillo}Restaurando la copia de segirudad ...        Espera unos segundos ...${borra_colores}"
                    echo "";
                    rm -r /home/$usuario/.config/k* 0>/dev/null 1>/dev/null 2>/dev/null
                    rm -r /home/$usuario/.config/plasma* 0>/dev/null 1>/dev/null 2>/dev/null
                    sudo cp -r /$ruta_destino/$maquina"_de_"$usuario/escritorio/* /home/$usuario/.config/ 0>/dev/null 1>/dev/null 2>/dev/null
                    sudo chown $usuario:$usuario -R /home/$usuario/.config 0>/dev/null 1>/dev/null 2>/dev/null
                    
                    mkdir /home/$usuario/.local/share/applications 0>/dev/null 1>/dev/null 2>/dev/null
                    cp -r /$ruta_destino/$maquina"_de_"$usuario/applications/* /home/$usuario/.local/share/applications/ 0>/dev/null 1>/dev/null 2>/dev/null
                    
                    rm /home/$usuario/.config/menus/* 0>/dev/null 1>/dev/null 2>/dev/null
                    mkdir /home/$usuario/.config/menus 0>/dev/null 1>/dev/null 2>/dev/null
                    cp -r /$ruta_destino/$maquina"_de_"$usuario/menus/* /home/$usuario/.config/menus/ 0>/dev/null 1>/dev/null 2>/dev/null
                    
                    mkdir /home/$usuario/.local/share/plasma_icons 0>/dev/null 1>/dev/null 2>/dev/null
                    cp -r /$ruta_destino/$maquina"_de_"$usuario/plasma_icons/* /home/$usuario/.local/share/plasma_icons/ 0>/dev/null 1>/dev/null 2>/dev/null
                    
                    echo -e "  ${amarillo}Restauracion realizada, posiblemente tendras que reiniciar tu escritorio. ${borra_colores}";
                    echo ""
                    echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                    read pausa;
                else
                    echo "";
                    echo -e " ${rojo}Cancelada la restauracion. ${amarillo}Repite el proceso. ${borra_colores}";
                    echo ""
                    echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                    read pause;
                fi;
            else
                clear
                echo ""
                echo -e " ${amarillo}La carpeta/directorio $ruta_destino/$maquina _de_ $usuario. ${rojo}NO EXISTE${borra_colores}";
                echo -e " ${amarillo}No se encuentra copia para poder restaurar.${borra_colores}";
                echo ""
                echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                read pause;
            fi;
        else
            clear
            echo "";
            echo -e " ${amarillo}LA RUTA DE DESTINO NO ESTA DEFINIDA. Selecciona la opcion ( 1 ), para indicarla.${borra_colores}";
            echo "";
            echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
            read pause;
        fi;;
        
    5)  #borra un backup
        if [ $ruta_destino ] 2>/dev/null;
        then
            if [ -d $ruta_destino ];
            then
                clear;
                echo -e "${verde} Lista de respaldos en $ruta_destino.${borra_colores}";
                echo -e "${amarillo}"
                echo -e "-- ${verde}Listado de backups${borra_colores} --"
                echo -e "${amarillo}"
                ls -l $ruta_destino | awk '{print "       " $9}';
                echo -e "${borra_colores}"
                read -p " Dime nombre de Backup a borrar -->> " borra_backup;
                if [[ -d $ruta_destino/$borra_backup && $borra_backup ]] 2>/dev/null
                then
                    echo -e " ${amarillo}Se va a borrar el Backup ${rojo}$borra_backup ${amarillo}!${rojo}${borra_colores}"
                    read -p " Estas seguro (S/N) ? -->> " SN
                    if [[ $SN = "S" || $SN = "s" ]]
                    then
                        echo ""
                        echo -e " Borrado ${rojo} $borra_backup ${borra_colores}"
                        rm -r $ruta_destino/$borra_backup
                        sleep 3
                    else
                        echo ""
                        echo -e "${amarillo} No se borra nada. saliendo.${borra_colores}"
                        sleep 3
                    fi
                else
                    echo ""
                    echo -e "${amarillo} El Backup ${rojo}$borra_backup${amarillo} no existe o lo has escrito mal....${borra_colores}"
                    sleep 3
                fi
                
            else
                clear 
                echo ""
                echo "${amarillo} La ruta destino ${rojo}$ruta_destino${amarillo} no esta disponible";
                echo ""
                echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                read pausa;
            fi;
        else
            clear
            echo ""
            echo -e "  ${amarillo}LA RUTA DE DESTINO NO ESTA DEFINIDA. Selecciona la opcion ( 1 ), para indicarla.${borra_colores}";
            echo ""
            echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
            read pause;
        fi;;
    
    6)  #montar unidad temporal
        #comienza montar temporal
        clear
        echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
        echo -e "${verde}  Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
        echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
        echo ""
        echo -e "${verde} Nombre del script --> backup-escritorio.sukigsx.sh ${borra_colores}"
        echo -e ""
        echo -e "${verde} Funcionamiento.${borra_colores} Monta una unidad de red de forma TEMPORAL en tu distribucion de linux dentro de la ruta /mnt"
        echo ""
        echo -e " ${azul} Te pedira la ruta a absoluta a montar, ej, //192.168.1.100/direcion_la_carpeta__montar."
        echo -e " ${azul} Te pedira el nombre de usuario, ej oscar."
        echo -e " ${azul} Te pedira el nombre de carpeta destino y se montara en /mnt/nombre_de_carpeta."
        echo -e "${borra_colores}"
        echo -ne "${azul} Introduce ${verde}UNIDAD DE RED${azul} a montar con su direccion absoluta >> ${borra_colores}"; read unidad_carpeta
        echo -ne "${azul} Dime ${verde}NOMBRE DE USUARIO${azul} de la unidad de red >> ${borra_colores}"; read unidad_usuario
        echo -ne "${azul} Ingresa ${verde}PASSWORD${azul} del Usuario de la Unidad de red >> ${borra_colores}"; read unidad_password
        echo -ne "${azul} Asigna ${verde}NOMBRE DE CARPETA${azul} para destino /mnt >> ${borra_colores}"; read  nombre_destino
        echo ""
        echo -e "${amarillo}  Direccion a montar -->>${verde} $unidad_carpeta ${borra_colores}"
        echo -e "${amarillo}  Usuario            -->>${verde} $unidad_usuario ${borra_colores}"
        echo -e "${amarillo}  Password           -->>${verde} NO TE LO MUESTRO ${borra_colores}"
        echo -e "${amarillo}  Carpeta destino    -->>${verde} $nombre_destino ${borra_colores}"
        echo ""
        echo -ne "${azul} Es correpto (S/N en MAYUSCULA) ? ${amarillo}-->>${borra_colores} "; read correcto
        
        smbclient -U $unidad_usuario%$unidad_password -L $unidad_carpeta 0>/dev/null 2>/dev/null 1>/dev/null
        if [[ $? == 0 ]] && [[ $correcto = "S" ]] 2>/dev/null
        then
            sudo mkdir /mnt/$nombre_destino
            sudo mount -t cifs $unidad_carpeta /mnt/$nombre_destino -o user=$unidad_usuario,uid=$unidad_usuario,gid=$unidad_usuario 2>/dev/null
            if [ $? = 0 ]
            then
                echo ""
                echo -e " ${verde}Unidad montada, pulsa una tecla para continuar${borra_colores}"
                unidad_red=$unidad_carpeta
                read pause
            else
                echo ""
                echo -e " ${rojo}NO ha sido posible montar la unidad.${borra_colores}"
                echo ""
                echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"unidad_red="VALOR NO REQUERIDO"
                read pause
            fi
        else
            clear
            echo ""
            echo -e "${amarillo} Has seleccionado N o NO hay acceso a la direccion absoluta.${borra_colores}"
            echo -e "${amarillo} Saliendo. Selecciona opcion (5) si quieres internar de nuevo.${borra_colores}"
            echo ""
            echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
            read pause
        fi;;

    7)  #manual de funcionamiento
        clear
        echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
        echo -e "${verde}  Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
        echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
        echo ""
        echo -e "MANUAL DE AYUDA";
        echo ""
        echo -e "${azul}Opcion 0.${borra_colores} Actualiza el script."
        echo ""
        echo -e "${azul}Opcion 1.${borra_colores} Introduce la ruta de las copias de seguridad.";
        echo "          Se refiere a que hay que introducir la ruta en donde buscara o realizara las copias de seguridad.";
        echo "          Puede ser una ubicacion en local o en red, si es en red hay que montar la ruta en el sistema con la opcion 5.";
        echo "          El script comprobara la ruta indicada. El servidor de red tiene que tener habilitado el protocolo samba (smb).";
        echo "";
        echo -e "${azul}Opcion 2.${borra_colores} Listar las copias de seguridad.";
        echo "          Realizara un ls sobre la ruta introducida en la opcion 1 y podras ver las copias de escritorio que";
        echo "          existan en esa ruta, tambien es donde realizara las nuevas copias.";
        echo "";
        echo -e "${azul}Opcion 3.${borra_colores} Realizar copia o backup.";
        echo "          Este pasao creara una copia de todos los datos de tu escritorio a la ruta indicada en opcion 1";
        echo "          colocandole en nombre de la maquina y seguido el nombre de usuario como se puedes ver en el";
        echo "          ejemplo /tmp/amd-pc_de_sukigsx.";
        echo "";
        echo -e "${azul}Opcion 4.${borra_colores} Restaurar copia o backup.";
        echo "          Esto realizara la restauracion automatica, eso quiere decir que si previamente no existe una copia";
        echo "          o backup no la encontrara y no la podra restaurar.";
        echo "";
        echo -e "${azul}Opcion 5.${borra_colores} Borrar un Backup.";
        echo "          Te lista los backups que tienes y te pregunta cual quieres.";
        echo "";
        echo -e "${azul}Opcion 6.${borra_colores} Montar unidad de red de forma temporal.";
        echo "          Esta opcion te permite montar una unidad de red en tu sistema para poder realizar un backup o";
        echo "          restauracion en tu rscritorio, para ello tienes que saber:";
        echo "              - Comprobara el software necesario (cifs-utils y smbclient), sino estan instalados, los instalara.";
        echo "              - La ruta absoluta de tu servidor, ej //192.168.0.1/servidor/copia_escritorio.";
        echo "              - El nombre de usuario del servidor, ej pepito.";
        echo "              - La password del servidor y tener permisos, ej 12345.";
        echo "              - Y la direccion de la carpeta destino, en donde se montara en tu sistema. ej //tmp/copia/.";
        read pause;;
        
    99) #salir/atras
        ctrl_c;;
        
    *)  
        echo ""
        echo -e "${rojo} Opcion No disponible en el menu principal.....${borra_colores}"
        echo -e "${amarillo} Pulsa una tecla para continuar o ( control + c ) salir.${borra_colores}"
        read pause;;
esac
done
