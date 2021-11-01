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
if [ -d $ruta_destino ]
then
    clear
    echo -e "${amarillo} Existe unidad montada en la ruta /mnt/$nombre_destino ${borra_colores}"
    echo -e "${amarillo} Se procede a desmontar unidad y borrar la carpeta temporal con orden sudo umount.${borra_colores}"
    sudo umount $ruta_destino 2>/dev/null
    sudo rmdir $ruta_destino 2>/dev/null
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

#funcion de configuracion del script
function config_backup_escritorio()
{
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
while :
do
clear
echo ""
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
echo -e "${verde} Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
echo -e "${verde} Nombre del script --> backup-escritorio.sukigsx.sh ${borra_colores}"
echo ""
echo -e "${verde} Descripcion.${borra_colores} Copia/restaura la configuracion de tu escritorio."
echo -e ""
echo -e " Configuracion del script"
echo -e ""
echo -e "  1. ${azul}Copia de seguridad en local.${borra_colores}"
echo -e "  2. ${azul}Copia de seguridad en red por samba.${borra_colores}"
echo -e ""
echo -e " 90. ${azul}Ayuda de configuracion.${borra_colores}"
echo -e " 99. ${azul}Salir.${borra_colores}"
echo -e ""
read -p " Seleciona una opcion -> " opcion
case $opcion in
    1)  #copia de seguridad en local
        echo -e ""
        read -p " Dime la carpeta/directorio destino (/home/$(whoami)/carpeta_destino) -> " carpeta_destino;
            if [ -d /home/$(whoami)/$carpeta_destino ];
            then
                echo ""
                echo -e "${azul} Ruta destino -->>${verde} /home/$(whoami)/$carpeta_destino ${borra_colores}";
                echo -e "${azul} Usuario ------->>${verde} $(whoami) ${borra_colores}";
                echo -e "${azul} Maquina ------->>${verde} $(hostname) ${borra_colores}";
                echo ""
                read -p " Es correcto (S/N) -->> " correcto;
                    if [[ $correcto = "S" || $correcto = "s" ]] #si es correcto entra en el then
                    then 
                        #borra y crea el fichero de configuracion
                        rm config_backup_escritorio 2>/dev/null 1>/dev/null 0>/dev/null
                        echo "ruta_destino=/home/$(whoami)/$carpeta_destino" >> config_backup_escritorio;
                        echo "usuario=$(whoami)" >> config_backup_escritorio
                        echo "maquina=$(hostname)" >> config_backup_escritorio
                        source config_backup_escritorio
                        break
                    else
                        clear
                        echo -e ""
                        echo -e " ${amarillo}Se cancela la configuracion, ingresa de nuevo la nueva ruta.${borra_colores}";
                        echo -e " ${verde}Pulsa una tecla para continuar...${borra_colores}"
                        read pause;
                        source config_backup_escritorio
                    fi
            else
                clear
                echo "";
                echo -e " ${amarillo}La carpeta/directorio${rojo} /home/$(whoami)/$carpeta_destino${amarillo}.${rojo} NO EXISTE${borra_colores}";
                echo -e "";
                read -p " ¿ Quieres crearla (s/n) ? -> " sino
                if [[ $sino = "s" || $sino = "S" ]]
                then
                    mkdir /home/$(whoami)/$carpeta_destino
                    echo "ruta_destino=/home/$(whoami)/$carpeta_destino" >> config_backup_escritorio;
                    echo "usuario=$(whoami)" >> config_backup_escritorio
                    echo "maquina=$(hostname)" >> config_backup_escritorio
                    source config_backup_escritorio
                    break
                else
                    echo -e ""
                    echo -e "${amarillo} Perfecto, regresamos a la configuracion.${borra_colores}"
                    sleep 2
                fi
                
            fi
        ;;
        
    2)  #copia de sefuridad en unidad_red
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
        echo -e " ${amarillo} Te pedira la ruta a absoluta a montar, ej, //192.168.1.100/direcion_la_carpeta__montar."
        echo -e " ${amarillo} Te pedira el nombre de usuario del servidor samba, ej oscar."
        echo -e " ${amarillo} Te pedira el nombre de carpeta destino del servidor samba y se montara en /mnt/nombre_de_carpeta."
        echo -e "${borra_colores}"
        echo -ne "${azul} Introduce ${verde}DIRECCION DE CARPETA DEL SERVIDOR SAMBA${azul} a montar con su direccion absoluta >> ${borra_colores}"; read direccion_red
        echo -ne "${azul} Dime ${verde}NOMBRE DE USUARIO DEL SERVIDOR SAMBA${azul} de la unidad de red >> ${borra_colores}"; read usuario_red
        echo -ne "${azul} Asigna ${verde}NOMBRE DE CARPETA${azul} para destino /mnt >> ${borra_colores}"; read  ruta_destino
        echo ""
        echo -e "${amarillo}  Direccion de servidor samba a montar. -->>${verde} $direccion_red ${borra_colores}"
        echo -e "${amarillo}  Usuario del servidor samba.           -->>${verde} $usuario_red ${borra_colores}"
        echo -e "${amarillo}  Carpeta destino.                      -->>${verde} $ruta_destino ${borra_colores}"
        echo ""
        echo -ne "${azul} Es correpto (s/n) ? ${amarillo}-->>${borra_colores} "; read correcto
        if [[ $correcto = "S" || $correcto = "s" ]]
        then
            rm config_backup_escritorio 2>/dev/null 1>/dev/null 0>/dev/null
            echo "red=1" >> config_backup_escritorio
            echo "direccion_red=$direccion_red" >> config_backup_escritorio
            echo "usuario_red=$usuario_red" >> config_backup_escritorio
            echo "ruta_destino=/mnt/$ruta_destino" >> config_backup_escritorio
            echo "usuario=$(whoami)" >> config_backup_escritorio
            echo "maquina=$(hostname)" >> config_backup_escritorio
            source config_backup_escritorio
            wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
            echo ""
            echo -e "${amarillo}Contraseña del servidor samba.${borra_colores}"
            sudo mkdir $ruta_destino #2>/dev/null 1>/dev/null 0>/dev/null
            sudo mount -t cifs $direccion_red $ruta_destino -o user=$usuario_red,uid=$usuario_red,gid=$usuario_red #2>/dev/null 1>/dev/null 0>/dev/null
            montado_correcto=$?
            if [ $montado_correcto = "1" ]
            then
                sudo umount $ruta_destino 2>/dev/null
                sudo rmdir $ruta_destino 2>/dev/null
                rm config_backup_escritorio
                echo -e ""
                echo -e "${rojo} No se ha podido conectar con el servidor samba.${borra_colores}"
                echo -e "${amarillo} Repite el proceso.${borra_colores}"
                echo -e ""
                sleep 4
            else
                break
            fi
                       
        else
            echo -e ""
            echo -e "${amarillo} Todo cancelado, repite el proceso.${borra_colores}"
            sleep 2
        fi
        ;;
        
    90) #ayuda de configuracion
        clear
        echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
        echo -e "${verde}  Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
        echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
        echo ""
        echo -e "MANUAL DE AYUDA";
        echo ""
        echo -e "${azul}Opcion 1.${borra_colores} Copia de seguridad en local.";
        echo "          Te pedira el nombre de la carpeta/directorio para realizar los respaldos de tu configuracion de escritorio.";
        echo "          Si no existe la creara en el home de tu usuario y si existe la utilizara.";
        echo "          Ejemplo, (/home/tu_usuario/carpeta_destino)."
        echo "";
        echo -e "${azul}Opcion 2.${borra_colores} Copia de seguridad en red por servidor samba.";
        echo "          Tienes que disponer de acceso a tu servidor por medio de conexion (samba)";
        echo "          Seguidamente te pedira los datos necesarios para poner conectar al servidor samba, que son los siguientes:";
        echo "              - La ruta de donde se encuentra el servidor en tu red, incluyendo el camino a la carpeta de tu servidor."
        echo "                  Ejemplo, (//192.168.1.100/carpeta/carpeta_destino)"
        echo "              - El nombre de usuario que tiene acceso a tu servidor samba."
        echo "              - Y por ultimo tiene que montar esa carpeta de tu servidor samba en una carpeta de tu linux."
        echo "                  Por defecto sera en /mnt. Asi que te pedira el nombre de carpeta destino."
        echo "";
        echo -e "${azul} Nota.${borra_colores} "
        echo -e "${azul}Opcion 90.${borra_colores} Ayuda, lo que estas viendo.";
        echo "";
        echo -e "${azul}Opcion 99.${borra_colores} Salir/atras.";
        echo "";
        read pause
        ;;
        
    99) # salir
        ctrl_c
        ;;
    
    *)  #opcion no valida
        echo -e "${rojo} Opcion No disponible en el menu principal.....${borra_colores}"
        echo -e "${amarillo} Pulsa una tecla para continuar o ( control + c ) salir.${borra_colores}"
        read pause;;
        
esac
done
}


clear
echo -e ""
echo -e "${verde} Verificando software necesario.${borra_colores}"
echo -e ""
## Vericica conexion a internet
    if ping -c1 google.com &>/dev/null;
    then
        echo -e " [${verde}ok${borra_colores}] Conexion a internet."
        conexion="si" #sabemos si tenemos conexion a internet o no
    else
        echo -e " [${rojo}XX${borra_colores}] Conexion a internet."
        conexion="no" #sabemos si tenemos conexion a internet o no
    fi
    
for paquete in cifs-utils git wmctrl figlet smbclient diff #ponemos el fostware a instalar separado por espacios
do
    which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
    sino=$? #recojemos el 0 o 1 del resultado de which
    contador="1" #ponemos la variable contador a 1
    while [ $sino -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
    do
        if [ $contador = "4" ] || [ $conexion = "no" ] #si el contador es 4 entre en then y sino en else
        then #si entra en then es porque el contador es igual a 4 y no ha podido instalar o no hay conexion a internet
            echo ""
            echo -e " ${amarillo}NO se ha podido instalar ($paquete).${borra_colores}"
            echo -e " ${amarillo}Intentelo usted con la orden:${borra_colores}"
            echo -e " ${rojo}-- sudo apt install $paquete --${borra_colores}"
            echo -e ""
            echo -e " ${rojo}No se puede ejecutar el script.${borra_colores}"
            echo ""
            exit
        else #intenta instalar
            if [ $paquete = "cifs-utils" ]
            then
                which cifscreds 2>/dev/null 1>/dev/null 0>/dev/null
                cifscreds=$?
                if [ $cifscreds = "0" ]
                then
                    break
                else
                    echo " Instalando $paquete. Intento $contador/3."
                    sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
                    let "contador=contador+1" #incrementa la variable contador en 1
                    which cifscreds 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
                    sino=$? ##recojemos el 0 o 1 del resultado de which
                fi
            else
                echo " Instalando $paquete. Intento $contador/3."
                sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
                let "contador=contador+1" #incrementa la variable contador en 1
                which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
                sino=$? ##recojemos el 0 o 1 del resultado de which
            fi
        fi
done
    echo -e " [${verde}ok${borra_colores}] $paquete."

done
echo -e ""
echo -e "${verde} Continuamos...${borra_colores}"
sleep 2


#comprueba aztualiczacion del script

#comprueba aztualiczacion del script
if [ -e /usr/bin/backup-escritorio.sukigsx.sh ] #comprueba si se ha instalado el script con el deb, comprobando el fichero /usr/bin/inicio.sukigsx.sh
then
    ruta="/usr/bin"
    mkdir /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
    git clone https://github.com/sukigsx/Backup-esritorio.git /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
    diff /tmp/com_update/codigo/backup-escritorio.sukigsx.sh $ruta/backup-escritorio.sukigsx.sh 2>/dev/null 1>/dev/null 0>/dev/null
    if [ $? = "0" ] 2>/dev/null 1>/dev/null 0>/dev/null
    then
        echo -e " [${verde}ok${borra_colores}] script, esta actualizado."
    else
        echo -e " [${rojo}XX${borra_colores}] ${amarillo}script NO actualizado, puedes actualizarlo en la opcion ( 0 ).${borra_colores}";sleep 2
    fi
    sudo rm -r /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
else
    ruta=$(pwd)
    mkdir /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
    git clone https://github.com/sukigsx/Backup-esritorio.git /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
    diff /tmp/com_update/codigo/backup-escritorio.sukigsx.sh $ruta/backup-escritorio.sukigsx.sh 2>/dev/null 1>/dev/null 0>/dev/null
    if [ $? = "0" ] 2>/dev/null 1>/dev/null 0>/dev/null
    then
        echo -e " [${verde}ok${borra_colores}] script, esta actualizado."
    else
        echo -e " [${rojo}XX${borra_colores}] ${amarillo}script NO actualizado, puedes actualizarlo en la opcion ( 0 ).${borra_colores}";sleep 3
    fi
    sudo rm -r /tmp/com_update 2>/dev/null 1>/dev/null 0>/dev/null
fi

echo ""
echo -e " ${verde}Todo el software correcto.${borra_colores}"
sleep 3


#comprueba si exixte el fichero de configuracion
if [ -f config_backup_escritorio ]
then #si existe el fichero de configuracion lo carga
    source config_backup_escritorio
    if [ $red = 1 ]
    then
        wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
        clear
        echo -e "${rosa}"; figlet -c Configurado por red en servisor samba; echo -e "${borra_colores}"
        echo -e ""
        echo -e "${amarillo} Introduce la contraseña del servidor samba.${borra_colores}"
        echo -e ""
        sudo mkdir $ruta_destino
        sudo mount -t cifs $direccion_red $ruta_destino -o user=$usuario_red,uid=$usuario_red,gid=$usuario_red 2>/dev/null
    fi
else #si no existe carga la funcion de creacion del fichero de configuracion
    config_backup_escritorio
fi



#empieza lo gordo
#ruta_destino="VALOR REQUERIDO"
#unidad_red="VALOR NO REQUERIDO"

#ruta_destino=VARIABLE_VACIAS

#variable de nombre de usuario del sistema cargado
#usuario=$(whoami)
#variable de hostname del sistema cargado
#maquina=$(hostname)
#variable nombre destino
nombre_destino="No Montado"




while :
do
#maximiza la terminal.
wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
clear
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
echo -e "${verde} Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
echo ""
echo -e "${verde} Nombre del script --> backup-escritorio.sukigsx.sh ${borra_colores}"
echo ""
echo -e "${verde} Descripcion.${borra_colores} Copia/restaura la configuracion de tu escritorio."
echo ""
echo -e "${amarillo} Ruta seleccionada -->> ${rojo}$ruta_destino${borra_colores}"
echo ""
echo -e "  0.${azul} Actualizar el script.${borra_colores}"
echo ""
echo -e "  1.${azul} Configurar el script.${borra_colores}"
echo ""
echo -e "  2.${azul} Listar las copias que tienes en el servidor.${borra_colores}"
echo -e ""
echo -e "  3.${azul} Backup (Se eliminara el backup anterior).${borra_colores}"
echo -e "  4.${azul} Restaurar (Se restaura encima del que tienes).${borra_colores}"
echo -e ""
echo -e "  5.${azul} Borra un Backup.${borra_colores}"
echo ""
echo -e " 90.${azul} Manual de ayuda.${borra_colores}"
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
            read -p " Pulsa una tecla para continuar." pause
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
            read -p " Pulsa una tecla para continuar." pause
            ctrl_c;
        fi;;

    1)  #Configurar el script
        rm config_backup_escritorio 2>/dev/null 1>/dev/null 0>/dev/null
        sudo umount $ruta_destino 2>/dev/null
        sudo rmdir $ruta_destino 2>/dev/null
        config_backup_escritorio
        ;;
        
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
                echo -e ""
                echo -e "-- ${verde}Listado de backups --${borra_colores}"
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
    
    90)  #manual de funcionamiento
        clear
        echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
        echo -e "${verde}  Diseñado por sukigsx / Contacto:  sukisx.mbsistemas@gmail.com${borra_colores}"
        echo -e "${verde}                                    https://mbsistemas.ddns.net${borra_colores}"
        echo ""
        echo -e "MANUAL DE AYUDA";
        echo ""
        echo -e "${azul}Opcion 0.${borra_colores} Actualiza el script."
        echo ""
        echo -e "${azul}Opcion 1.${borra_colores} Configurar el script.";
        echo "          Crea un fichero de configuracion (config_backup_escritorio), donde almacena los datos para crear backup";
        echo "          y las restauraciones de tu configuracion de escritorio.";
        echo "";
        echo -e "${azul}Opcion 2.${borra_colores} Listar las copias de seguridad.";
        echo "          Realizara un (ls) sobre la ruta introducida en la opcion 1 y podras ver las copias de configuracion de";
        echo "          tu escritorio que existan en esa ruta, tambien es donde realizara las nuevas copias.";
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
        echo "          Te lista los backups que tienes y te pregunta cual quieres borrar.";
        echo "";
        echo -e "${azul}Opcion 90.${borra_colores} Ayuda, lo que estas viendo.";
        echo "";
        echo -e "${azul}Opcion 99.${borra_colores} Salir/atras.";
        echo "";
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
