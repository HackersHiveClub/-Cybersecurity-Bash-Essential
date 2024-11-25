#!/bin/bash

echo "Iniciando o script de longa duração..."

# Contagem de 1 a 30 com intervalo de 10 segundos entre os números
for i in {1..30}; do
    echo "Contando: $i"
    sleep 5  # Pausa de 5 segundos
done

echo "Script concluído!"
