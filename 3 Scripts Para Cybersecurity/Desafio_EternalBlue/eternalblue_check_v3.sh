#!/bin/bash

# Script para verificar vulnerabilidade ao EternalBlue usando Nmap

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

# Executar o Nmap com o script smb-vuln-ms17-010 e salvar a saída em um arquivo temporário
OUTPUT=$(mktemp)
nmap --script smb-vuln-ms17-010 -p 445 $TARGET > "$OUTPUT"

# Verificar se o comando foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Varredura concluída. Verificando resultados..."
    
    # Procurar a palavra "VULNERABLE" no resultado
    if grep -q "VULNERABLE" "$OUTPUT"; then
        # Mensagem em vermelho para vulnerável
        echo -e "\e[31m[ALERTA] O servidor $TARGET está VULNERÁVEL ao EternalBlue!\e[0m"
    else
        echo -e "\e[32m[INFO] O servidor $TARGET não está vulnerável ao EternalBlue.\e[0m"
    fi
else
    echo "Ocorreu um erro durante a varredura. Verifique o endereço IP e tente novamente."
fi

# Limpar o arquivo temporário
rm -f "$OUTPUT"
