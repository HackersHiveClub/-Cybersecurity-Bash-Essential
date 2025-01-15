#!/bin/bash

# Verificar se o Nmap está instalado
if ! command -v nmap &>/dev/null; then
    echo "Erro: Nmap não está instalado. Instale-o e tente novamente."
    exit 1
fi

# Verificar se o IP foi fornecido
if [ -z "$1" ]; then
    echo "Uso: $0 <endereço_IP>"
    exit 1
fi

TARGET=$1

# Mensagem de início
echo "Verificando vulnerabilidade ao EternalBlue no servidor $TARGET..."

# Executar o Nmap com o script smb-vuln-ms17-010
nmap --script smb-vuln-ms17-010 -p 445 $TARGET

# Verificar o resultado do último comando
if [ $? -eq 0 ]; then
    echo "Varredura concluída. Verifique o resultado acima para determinar se o servidor está vulnerável."
else
    echo "Ocorreu um erro durante a varredura. Verifique o endereço IP e tente novamente."
fi
