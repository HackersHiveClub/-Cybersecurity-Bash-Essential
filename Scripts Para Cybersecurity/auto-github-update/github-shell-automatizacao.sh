#!/bin/bash
# Comandos iniciais
# git clone https://github.com/HackersHiveClub/exemplo
# cd demo
# git config --global user.email "seu[@]gmail.com"
# git config --global user.name "seu_username"
# git remote set-url origin https://seu_token@github.com/HackersHiveClub/exemplo
#-----------------------------------------------------------------------------------------------

# Caminho para a pasta onde os scripts são criados
pasta_scripts=/curso-bash/demo

# Mensagem de commit padrão
mensagem_commit="Adicionando novos scripts automaticamente no repositorio DEMO"

# Navega para a pasta
cd $pasta_scripts

# Adiciona todos os arquivos novos ou modificados ao Git
git add .

# Realiza o commit (ignora se não houver mudanças)
git commit -m "$mensagem_commit" 2>/dev/null

# Envia os arquivos para o repositório no GitHub
git push origin main
