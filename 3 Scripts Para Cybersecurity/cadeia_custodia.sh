#!/bin/bash

# Solicitar o diretório ao usuário
read -p "Digite o caminho do diretório que deseja gerar os hashes: " target_dir

# Verificar se o diretório existe
if [ ! -d "$target_dir" ]; then
    echo "Erro: O diretório especificado não existe."
    exit 1
fi

# Informações para o cabeçalho
username=$(whoami)
current_date=$(date +"%d-%m-%Y %H:%M:%S")
computer_name=$(hostname)
output_file="$target_dir/hash_cadeia_custodia.txt"

# Criar o arquivo de saída com o cabeçalho
echo "# Cadeia de Custódia" > "$output_file"
echo "# Usuário: $username" >> "$output_file"
echo "# Data: $current_date" >> "$output_file"
echo "# Diretório: $target_dir" >> "$output_file"
echo "# Computador: $computer_name" >> "$output_file"
echo "" >> "$output_file"

# Gerar os hashes SHA1 de todos os arquivos no diretório
find "$target_dir" -type f | while read -r file; do
    sha1sum "$file" >> "$output_file"
done

echo "Hashes gerados com sucesso! Os resultados foram salvos em $output_file."
sha1sum $output_file  >> $target_dir/hash_cadeia_custodia.sha1
