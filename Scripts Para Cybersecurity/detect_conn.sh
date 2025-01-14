#!/bin/bash

# Script para detectar conexões de rede incomuns

echo "Detectando conexões de rede incomuns..."
echo "======================================="

# Lista de portas conhecidas (comum para servidores e serviços locais)
KNOWN_PORTS=(80 443 22 25 53 3306 8080)

# Definir o comando (netstat ou ss) com base na disponibilidade
if command -v ss &>/dev/null; then
    CMD="ss -tunap"
else
    CMD="netstat -tunap"
fi

# Executar o comando e filtrar conexões estabelecidas
OUTPUT=$($CMD | grep ESTAB)

# Verificar se há conexões ativas
if [[ -z "$OUTPUT" ]]; then
    echo "Nenhuma conexão ativa encontrada."
    exit 0
fi

echo "Conexões encontradas:"
echo "$OUTPUT"
echo

echo "Verificando conexões incomuns..."
while read -r LINE; do
    # Extrair porta remota (último campo da coluna de destino)
    PORT=$(echo "$LINE" | awk '{print $5}' | awk -F':' '{print $NF}')
    
    # Verificar se a porta está na lista de portas conhecidas
    if [[ ! " ${KNOWN_PORTS[@]} " =~ " ${PORT} " ]]; then
        echo "Conexão incomum detectada: $LINE"
    fi
done <<<"$OUTPUT"

echo "Detecção concluída."
