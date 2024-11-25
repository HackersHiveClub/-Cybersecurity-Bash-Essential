#!/bin/bash

# Scanner de hosts


#Validar o argumento
if [ $# -eq 0 ]; then 
  echo "O arquivo $0 requer ao menos um endereço IP"
  fi

IP=$1
echo "Validando o endereço IP $@" 
ping -c 3 $IP

