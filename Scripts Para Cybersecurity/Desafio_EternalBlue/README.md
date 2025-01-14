## Passo a Passo para o Desafio

### 1. Executar o Nmap Diretamente

Antes de criar o script, execute o comando do Nmap diretamente no terminal para 
testar. Substitua `<endereço_IP>` pelo IP do servidor que você deseja testar:

`nmap --script smb-vuln-ms17-010 -p 445 <endereço_IP>` 

Garanta que a saída do Nmap mostre claramente se o servidor está vulnerável ou não. Essa etapa é essencial para confirmar que o Nmap está funcionando como esperado.

----------

### 2. Crie o Script Passo a Passo

Comece criando um script simples que apenas execute o comando do Nmap com um endereço IP fixo. O script deve ser algo como:

`#!/bin/bash
nmap --script smb-vuln-ms17-010 -p 445 127.0.0.1` 

Certifique-se de salvar o arquivo com a extensão `.sh` (por exemplo, `script_basico.sh`) e torná-lo executável usando o comando:

`chmod +x script_basico.sh` 

Execute o script e verifique se o resultado é o esperado.

----------

### 3. Adicione Validações Gradualmente

Agora, vamos tornar o script mais robusto adicionando validações.

1.  **Verifique se o Nmap está instalado:** Adicione uma validação para confirmar se o Nmap está instalado no sistema antes de tentar usá-lo.
   
   
`if ! command -v nmap &>/dev/null; then`   
  `      echo "Erro: Nmap não está instalado."`  
    `    exit 1`   
    `fi`   
    
2.  **Valide se o endereço IP foi fornecido:** Adicione uma verificação para garantir que o usuário forneça um endereço IP como argumento ao script.
    
   
   `if [ -z "$1" ]; then` 
   `     echo "Uso: $0 <endereço_IP>"` 
        `exit 1` 
    `fi` 
    

----------

### 4. Aprimore o Script com Recursos Adicionais

Agora que o script básico funciona, vamos aprimorá-lo.

1.  **Adicione mensagens mais claras:** Mostre mensagens para o usuário indicando o que está acontecendo:
    
    
    `echo "Iniciando verificação no servidor $1..."` 
    
2.  **Valide o resultado da varredura:** Verifique se a execução do Nmap foi bem-sucedida e mostre uma mensagem apropriada.
    
    
    `nmap --script smb-vuln-ms17-010 -p 445 $1` 
   `  if [ $? -eq 0 ]; then` 
    `     echo "Varredura concluída. Verifique os resultados acima."` 
    ` else` 
     `    echo "Erro ao executar a varredura. Tente novamente."` 
   `  fi` 
    

----------

### 5. Teste o Script em Diferentes Situações

Teste o script em várias condições para garantir que ele funcione corretamente:

-   Com um IP válido (máquina que possui o SMB habilitado).
-   Com um IP inválido ou que não esteja acessível.
-   Sem fornecer um IP como argumento.

Garanta que o script lide bem com todas essas situações.

----------

### 6. Documente o Uso do Script

Inclua no início do script ou em um arquivo separado (README) as instruções de uso:

-   **Como executar:**
    
    
    `./seu_script.sh <endereço_IP>` 
    
-   **O que esperar como saída:**
    
    -   Mensagens indicando o progresso da varredura.
    -   Resultados mostrando se o servidor está vulnerável ou não.
-   **Como interpretar os resultados:** Explique brevemente como identificar uma vulnerabilidade com base na saída do Nmap.
    

----------

### 7. Desafios Extras para Aprimorar

Para alunos que desejam um desafio maior, considere:

1.  **Salvar os resultados em um arquivo:** Adicione uma opção para salvar os resultados da varredura em um arquivo.
    
   
    `nmap --script smb-vuln-ms17-010 -p 445 $1 > resultado.txt` 
    
2.  **Suporte a múltiplos IPs:** Modifique o script para aceitar vários IPs como argumentos e realizar a varredura em todos eles.
    
    
    `for ip in "$@"; do`
    `     echo "Verificando $ip..."`
  `       nmap --script smb-vuln-ms17-010 -p 445 $ip`
 `    done` 
    

----------

### Exemplo de Fluxo Didático

1.  **Início:** Execute o comando Nmap manualmente para entender seu funcionamento.
2.  **Intermediário:** Crie um script básico sem validações.
3.  **Avançado:** Aprimore o script com validações, suporte a múltiplos IPs e opções para salvar os resultados.
