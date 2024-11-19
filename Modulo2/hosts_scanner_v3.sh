#!/bin/bash

# Scanner de hosts
# Validar o argumento
 if [ $# -eq 0 ]; then 
 echo "O arquivo $0 requer ao menos um endereço IP"
 exit 1
 fi

# Loop de todos end. IPS
for ips in "$@"; do
echo "Verificando se o host $ips está ativo..."
# Realiza o ping em cada IP  
ping -c 1 $ips > /dev/null

# verificar o status de cada IP
if [ $? -eq 0 ]; then
echo "O Host #ips está ativo (respondeu ao ping)"
else
echo "O Host #ips não está ativo (não respondeu ao ping)"
 fi
done
