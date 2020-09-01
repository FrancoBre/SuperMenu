#!/bin/bash
#------------------------------------------------------
# PALETA DE COLORES
#------------------------------------------------------
#setaf para color de letras/setab: color de fondo
	red=`tput setaf 1`;
	green=`tput setaf 2`;
	blue=`tput setaf 4`;
	bg_blue=`tput setab 4`;
	reset=`tput sgr0`;
	bold=`tput setaf bold`;

#------------------------------------------------------
# TODO: Completar con su path
#------------------------------------------------------

proyectoActual="/home/franco/kurapika/bregoli-arevalo-sor"

#------------------------------------------------------
# DISPLAY MENU
#------------------------------------------------------
imprimir_menu () {
    imprimir_encabezado "\t  S  U  P  E  R  -  M  E  N U ";
	
    echo -e "\t\t El proyecto actual es:";
    echo -e "\t\t $proyectoActual";
    
    echo -e "\t\t";
    echo -e "\t\t Opciones:";
    echo "";
    echo -e "\t\t\t a.  Ver estado del proyecto";
    echo -e "\t\t\t b.  Guardar cambios";
    echo -e "\t\t\t c.  Actualizar repo";
    echo -e "\t\t\t f.  Abrir en terminal";        
    echo -e "\t\t\t g.  Abrir en carpeta"; 
    echo -e "\t\t\t h.  Fork y wait";
    echo -e "\t\t\t l.  Filósofos";
    echo -e "\t\t\t s.  Sincronización";
    
    echo -e "\t\t\t q.  Salir";
    echo "";
    echo -e "Escriba la opción y presione ENTER";
}

Ver_Estado (){
	var=$((git log HEAD..origin/master --oneline) 2>&1);
	if [ -z "$var" ]
	then
		#no fueron encontrados logs, por lo que no hay cambios en el repo
		PULL="Pulse enter para empezar a trabajar";
	else
		#fueron encontrados datos en el log, por lo que hay cambios en el repo
		#que se deben traer
		clear;
		PULL="Es preciso realizar un git pull antes de empezar a trabajar";
		read enter;
		clear;
	fi
	
	#echo ls -l;
	echo "---------------------------";
	imprimir_encabezado $PULL;
	echo "---------------------------";    
}

#------------------------------------------------------
# FUNCTIONES AUXILIARES
#------------------------------------------------------

imprimir_encabezado () {
    #Se le agrega formato a la fecha que muestra
    #Se agrega variable $USER para ver que usuario está ejecutando
    echo -e "`date +"%d-%m-%Y %T" `\t\t\t\t\t USERNAME:$USER";
    echo "";
    #Se agregan colores a encabezado
    echo -e "\t\t ${bg_blue} ${red} ${bold}--------------------------------------\t${reset}";
    echo -e "\t\t ${bold}${bg_blue}${red}$1\t\t${reset}";
    echo -e "\t\t ${bg_blue}${red} ${bold} --------------------------------------\t${reset}";
    echo "";
}

esperar () {
    echo "";
    echo -e "Presione enter para continuar";
    read ENTER ;
}

malaEleccion () {
    echo -e "Selección Inválida ..." ;
}

decidir () {
	echo $1;
	while true; do
		echo "Ingrese sí o no (s/n)";
    		read respuesta;
    		case $respuesta in
        		[Nn]* ) break;;
       			[Ss]* ) eval $1
				break;;
        		* ) echo "Por favor ingresar S/s ó N/n.";;
    		esac
	done
}

#------------------------------------------------------
# FUNCTIONES del MENU
#------------------------------------------------------

a_funcion () {
    	imprimir_encabezado "\tOpción a.  Ver estado del proyecto";
	echo "---------------------------"        
	echo "Somthing to commit?"
        decidir "cd $proyectoActual; git status";

        echo "---------------------------"        
	echo "Incoming changes (need a pull)?"
	decidir "cd $proyectoActual; git fetch origin"
	decidir "cd $proyectoActual; git log HEAD..origin/master --oneline"
}

b_funcion () {
       	imprimir_encabezado "\tOpción b.  Guardar cambios";
       	decidir "cd $proyectoActual; git add -A";
       	echo "Ingrese mensaje para el commit:";
       	read mensaje;
       	decidir "cd $proyectoActual; git commit -m \"$mensaje\"";
       	decidir "cd $proyectoActual; git push";
}

c_funcion () {
      	imprimir_encabezado "\tOpción c.  Actualizar repo";
      	decidir "cd $proyectoActual; git pull";   	 
}


f_funcion () {
	imprimir_encabezado "\tOpción f.  Abrir en terminal";        
	decidir "cd $proyectoActual; xterm &";
}

g_funcion () {
	imprimir_encabezado "\tOpción g.  Abrir en carpeta";        
	decidir "gnome-open $proyectoActual &";
}

#------------------------------------------------------
# TODO: Completar con el resto de ejercicios del TP, una funcion por cada item
#------------------------------------------------------

ver_estado (){
	var=$((git log HEAD..origin/master --oneline)2>&1);
	if test -z "$var"
	then
		#no fueron encontrados logs, por lo que no hay cambios en el repo
		imprimir_encabezado "   Pulse enter para empezar a trabajar";
		echo "Presione enter";
	else
		#fueron encontrados datos en el log, por lo que hay cambios en el repo
		#que se deben traer
		imprimir_encabezado "      Por favor realice un git pull";
		echo "Presione enter";

	fi
	read enter;
	clear;
}

h_funcion () {
	imprimir_encabezado "\t     Opción h. Fork y wait";
	cat ejercicios.txt | grep -i fork;
	echo "Desea ver el enunciado?";
	decidir "cd $proyectoActual; cat fork-wait.txt";	
	echo "Desea ver el código?";
	decidir "cd $proyectoActual; cat do_nothing.c; cat do_nothing_v2.c; cat do_nothing_v3.c";
	echo "";
	echo "Desea ejecutar el programa?";
	decidir "cd $proyectoActual; time ./do_nothing";
	decidir "cd $proyectoActual; time ./do_nothing_v2";
	decidir "cd $proyectoActual; time ./do_nothing_v3";
}

l_funcion () {
	imprimir_encabezado "\t       Opción l. Filósofos";
	cat ejercicios.txt | grep -i exclusión;
	echo "Desea ver el enunciado?";
	decidir "cd $proyectoActual; cat filosofos.txt";	
	echo "Desea ver el código?";
	decidir "cd $proyectoActual; cat filosofos.c";
	echo "";
	echo "Desea ejecutar el programa?";
	decidir "cd $proyectoActual; ./filosofos";
}

s_funcion () {
	imprimir_encabezado "\t      Opción s. Sincronización";
	cat ejercicios.txt | grep -i sincronización;
	echo "Desea ver el enunciado?";
	decidir "cd $proyectoActual; cat sincronizacion.txt";	
	echo "Desea ver el código?";
	decidir "cd $proyectoActual; cat sincronizacion.c";
	echo "";	
	echo "Elija un número y presione enter";
	read num;
	echo "";
	echo "Desea ejecutar el programa?";
	decidir "cd $proyectoActual; ./sincronizacion $num";
}

#------------------------------------------------------
# LOGICA PRINCIPAL
#------------------------------------------------------

# 1. informar al usuario si hace falta realizar un git pull
ver_estado;
while  true
do
# 2. mostrar el menu
    imprimir_menu;
# 3. leer la opcion del usuario
    read opcion;
    
    case $opcion in
        a|A) a_funcion;;
        b|B) b_funcion;;
        c|C) c_funcion;;
        d|D) d_funcion;;
        e|E) e_funcion;;
        f|F) f_funcion;;
        g|G) g_funcion;;
        h|H) h_funcion;;
        l|L) l_funcion;;
        s|S) s_funcion;;
        q|Q) break;;
        *) malaEleccion;;
    esac
    esperar;
done
 
