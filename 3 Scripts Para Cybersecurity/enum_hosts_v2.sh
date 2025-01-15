#!/bin/bash

#Enumera hosts na rede

#Verifica se o NMAP está instalado.

if ! command -v nmap &> /dev/null; then
echo "Erro: O nmap não está instalado no sistema."
exit 1
fi

#Verifica passagem de argumento

if [ -z "$1" ]; then
  echo "Use $0 <rede com notação CIDR>"
  echo "Exemplo: $0 192.168.0.0/24"
exit 1
fi


REDE=$1

#Valida formato CIDR (IP)

  if [[ ! "$REDE" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+$ ]]; then
  echo "Formato Inválido da notação CIDR , exemplo 192.168.0.0/24"
exit 1
fi


echo "Escaneando a rede $REDE em busca de hosts ativos"
nmap -sn $REDE | grep "Nmap scan report for" | awk '{print $5}' > hosts_ativos.txt

clear
echo "==============================="
echo "Hosts Ativos na Rede $REDE"
echo "==============================="
cat hosts_ativos.txt




