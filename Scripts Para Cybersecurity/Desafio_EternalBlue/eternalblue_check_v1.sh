#!/bin/bash

#Script para verificar vulnerabilidade EternalBlue

#Verificar se o IP foi fornecido
if [ -z "$1" ]; then
 echo "Uso:$0 <endereço_IP>"
exit 1
fi

ALVO=$1

echo Verificando vulnerabilidade ao EternalBlue no servidor $ALVO
nmap -p445 --script smb-vuln-ms17-010 $ALVO

