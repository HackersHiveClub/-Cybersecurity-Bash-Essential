#!/bin/bash
# Descrição

# Cores para saída
Color_Off='\033[0m'       # Resetar cor
Red='\033[0;31m'          # Vermelho
Green='\033[0;32m'        # Verde
Blue='\033[0;34m'         # Azul
Cyan='\033[0;36m'         # Ciano
Yellow='\033[0;33m'       # Amarelo



# Validar comando
if ! command -v less &> /dev/null; then
 echo -e "${Red}ERRO:Comando não encontrado${Color_Off}"
exit 1
fi


if [ -z "$1" ]; then
  echo -e "${Red}Exemplo de argumento${Color+Off}"
exit 1
fi
