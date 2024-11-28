#!/bin/bash

# Função para validar se um arquivo existe e verificar permissões
valida_arquivo() {
    local arquivo="$1"

    if [ -e "$arquivo" ]; then
        echo "O arquivo '$arquivo' existe."

        if [ -r "$arquivo" ]; then
            echo "- Possui permissão de leitura."
        else
            echo "- Não possui permissão de leitura."
        fi

        if [ -w "$arquivo" ]; then
            echo "- Possui permissão de escrita."
        else
            echo "- Não possui permissão de escrita."
        fi

        if [ -x "$arquivo" ]; then
            echo "- Possui permissão de execução."
        else
            echo "- Não possui permissão de execução."
        fi
    else
        echo "O arquivo '$arquivo' NÃO existe."
    fi
}

# Uso da função
echo "Digite o caminho do arquivo para validar:"
read caminho

valida_arquivo "$caminho"


