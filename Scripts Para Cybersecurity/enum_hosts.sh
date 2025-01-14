#!/bin/bash

#Enumera hosts na rede

# Verificar o NMAP
if ! command -v nmap &> /dev/null; then
echo "ERRO: Nmap não instalado"
exit 1
fi


if [ -z "$1" ]; then
  echo "Use $0 <rede com notação CIDR>"
  echo "Exemplo: $0 192.168.0.0/24"
exit 1
fi

REDE=$1

# Validar usando REGEX se a notação CIDR está correta 
if [[ ! "$REDE" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+$ ]]; then
echo ERRO: Formato de rede inválido. Exemplo 10.0.0.0/16
exit 1
fi


echo "Escaneando a rede $REDE em busca de hosts ativos"
nmap -sn $REDE | grep "Nmap scan report for" | awk '{print $5}' > hosts_ativos.txt
clear
if [ -s hosts_ativos.txt ]; then
echo "+-----------------------+"
echo " Hosts Ativos Detectados"
echo "+-----------------------+"
#Validar se o arquivo existe e se tem conteudo.
cat hosts_ativos.txt

else
echo "ERRO:O arquivo hosts_ativos.txt não foi encontrado"
fi




