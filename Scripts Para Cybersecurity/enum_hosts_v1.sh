#!/bin/bash

#Enumera hosts na rede

if [ -z "$1" ]; then
  echo "Use $0 <rede com notação CIDR>"
  echo "Exemplo: $0 192.168.0.0/24"
exit 1
fi

REDE=$1

echo "Escaneando a rede $REDE em busca de hosts ativos"
nmap -sn $REDE | grep "Nmap scan report for" | awk '{print $5}' > hosts_ativos.txt
clear
echo "Hosts Ativos Detectados"
cat hosts_ativos.txt




