#!/bin/bash
# Exemplo de função

validar_entrada() {
  if [[ -z "$1" ]];then
  echo "ERRO: Nenhuma entrada fornecida"
 exit 1
 fi
 }

validar_entrada "$1"
echo "Entrada validada $1. Segue o jogo"

