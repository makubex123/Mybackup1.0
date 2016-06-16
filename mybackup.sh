#!/bin/bash
#Este script hace un backup de los archivos que especifiques
#Variables
red='\033[0;31m'
nocolors='\033[0m'
linea="======================================================="
backup="$@"
#====================================================================================================================================================================
                                                          #IMPRESION DEL SALUDO
echo $linea
echo
printf "Gracias ${red}$USER ${nocolors}por ejecutar My Backup 3.2"
echo
echo
echo $linea
#====================================================================================================================================================================
    #Bloque de codigo a imprimir cuando no se digita ningun agumento, luego del script
if [[ $# -eq 0 ]]; then
 echo -e "\n Espera..... no digitaste ningun argumento\n"
 echo -e "USAGE: $0 <Archivo 1> <Archivo 2> <Archivo 3> <Archivo n>"
 exit 1
fi

#=====================================================================================================================================================================
#En este segmento verifica si los archivos que el usuario esta pasando como argumento no existen le desplegara un mensaje para que introduzca archivos existentes, el for verifica uno cada uno

for d in $backup
do
if [[ ! -f $d ]]; then
    echo -e "\n Los archivos $d no existen favor introduce archivos existentes para proceder con el backup \n"
    exit 1
fi
done

#=====================================================================================================================================================================
#En este bloque verifica si los archivos que estan pasando como argumento existen, y si existen procede a copiarlos al directorio $USER.backup si ya el directorio existe.

if [[ -f $backup ]]; then
echo -e "\n He comprobado que los archivos $backup existen, procediendo....\n"
fi

#==================================================================================================================================================================================
#En este bloque verifica si el directorio $USER.backup existe, y si existe procede a copiar los archivos hacia el directorio

if [ ! -d /home/$USER/$USER.backup ] ; then
read -n 1 -p "He verficado que el directorio "$USER.backup" no existe, desea crearlo? (y/n)" choose

  if [[ $choose == 'y' ]]; then
  echo -e "\n Creando el directorio $USER.backup \n"
  sleep 2
  mkdir /home/$USER/$USER.backup
  echo -e "\n Copiando los archivo al directorio $USER.backup \n"
  sleep 2

for a in $backup
do
  cp $a /home/$USER/$USER.backup/$a.bak
done

fi
fi

if [ -d /home/$USER/$USER.backup ]; then
sleep 2
for i in $backup
do
cp $i /home/$USER/$USER.backup/$i.bak
done
echo -e "\n Copiando los archivos $backup al directorio $USER.backup espere... \n "

#En esta linea de comando manda un correo cuando el backup se ha completadom correctamente, NOTA!!! PARA QUE ESTO FUNCIONE TIENE QUE TENER INSTALADO EL PAQUETE mailutils 

echo "los archivos se han copiado correctamente" | mail -s "MyBackupReport" adam.daniels.stallman@gmail.com
fi
sleep 2

echo -e Done

#By Makubex!
