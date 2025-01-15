#!/bin/bash
#Enumera hosts na rede

# Cores para saída
Color_Off='\033[0m'       # Resetar cor
Red='\033[0;31m'          # Vermelho
Green='\033[0;32m'        # Verde
Blue='\033[0;34m'         # Azul
Cyan='\033[0;36m'         # Ciano
Yellow='\033[0;33m'       # Amarelo



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


echo "Escaneando a rede $REDE, Isso pode demorar alguns minutos..."
# nmap -sn $REDE | grep "Nmap scan report for" | awk '{print $5}' > hosts_ativos.txt
  nmap -O -sV $REDE -oN hosts_ativos.txt > /dev/null 2>&1

clear
#Validar se o arquivo existe e se tem conteudo.

if [ -s hosts_ativos.txt ]; then
    echo -e "${Cyan}+---------------------------+${Color_Off}"
    echo -e "${Green}  Hosts Ativos Detectados${Color_Off}"
    echo -e "${Cyan}+---------------------------+${Color_Off}"
    
    grep -E "Nmap scan report for|OS:|open" hosts_ativos.txt | awk '
    /Nmap scan report for/ {print "\n" "'"${Yellow}"'" "Host: " $5 "'"${Color_Off}"'"}
    /OS:/ {print "'"${Blue}"'" "Sistema Operacional: " $2 " " $3 " " $4 "'"${Color_Off}"'"}
    /open/ {print "'"${Red}"'" "Porta Aberta: " $1 " (" $NF ")" "'"${Color_Off}"'"}'

else
    echo -e "${Red}ERRO: O arquivo hosts_ativos.txt não foi encontrado ou está vazio.${Color_Off}"
fi
