#!/bin/bash
############################################################
# Code fuer ein C-Programm wird ueber das Skript           #
# an den gcc uebergeben und compiliert.                    #
# Im Anschluss wird das Programm im Hintergrund gestartet  #
# und mittels der PID und kill beendet                     #
############################################################

############################################################
# Uebergabe des Codes an den gcc
gcc -o ./c_file -x c - << EOF
#include <stdio.h>
int main()
{
	printf("Embedded-Code Programm");
	while(1);
	return 0;
}
EOF


# Das C-Programm wird im Hintergrund gestartet
./c_file&
echo "Programm läuft"
ps

# Das Programm wird ueber seine PID mit kill beendet
kill $(ps -C c_file -o pid=)
echo "Programm läuft nicht"
ps 

# Das Programm wird nochmal gestartet
./c_file&
kill -KILL %1 && echo "Programm beendet."

# Das C-Programm wird geloescht
rm ./c_file

