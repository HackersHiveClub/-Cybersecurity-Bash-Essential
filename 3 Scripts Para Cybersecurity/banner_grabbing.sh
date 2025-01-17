#!/bin/bash

# Banner Grep Script para Pentest Controlado - Revisado

# Verifica os parâmetros necessários
if [ "$#" -lt 2 ]; then
    echo "Uso: $0 <rede> <arquivo_de_portas>"
    echo "Exemplo: $0 192.168.1.0/24 portas.txt"
    exit 1
fi

REDE=$1
PORTAS_FILE=$2
OUTPUT_FILE="banners_output.txt"

# Verifica se o arquivo de portas existe e não está vazio
if [ ! -f "$PORTAS_FILE" ] || [ ! -s "$PORTAS_FILE" ]; then
    echo "Erro: O arquivo '$PORTAS_FILE' não existe ou está vazio."
    exit 1
fi

# Limpa o arquivo de saída, se existir
> "$OUTPUT_FILE"

# Função para coletar banners de um host
coletar_banners() {
    local host=$1
    while read -r porta; do
        echo "[*] Tentando $host:$porta"
        # Conecta à porta e tenta obter o banner
        BANNER=$(timeout 3 nc -nv "$host" "$porta" 2>&1)
        
        # Verifica se houve algum retorno e salva no arquivo
        if [[ -n "$BANNER" ]]; then
            echo "[+] Banner encontrado em $host:$porta" | tee -a "$OUTPUT_FILE"
            echo "$BANNER" >> "$OUTPUT_FILE"
            echo "---" >> "$OUTPUT_FILE"
        else
            echo "[-] Nenhum banner em $host:$porta"
        fi
    done < "$PORTAS_FILE"
}

# Descobre hosts ativos na rede
echo "[*] Descobrindo hosts ativos em $REDE..."
mapfile -t HOSTS < <(nmap -sn "$REDE" | grep "scan report" | awk '{print $5}')

if [ "${#HOSTS[@]}" -eq 0 ]; then
    echo "Erro: Nenhum host ativo encontrado em $REDE."
    exit 1
fi

# Itera sobre cada host ativo para coletar banners
for host in "${HOSTS[@]}"; do
    echo "[*] Coletando banners para $host..."
    coletar_banners "$host"
done

echo "[*] Banners coletados foram salvos em $OUTPUT_FILE"
