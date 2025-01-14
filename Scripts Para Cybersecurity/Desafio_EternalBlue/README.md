# Tarefa de Aula: Verificando Vulnerabilidade ao EternalBlue com Nmap

## Objetivo
Nesta tarefa, você deverá usar o Nmap em um shell script para identificar a vulnerabilidade EternalBlue (MS17-010) em um servidor.

---

## Requisitos

### Um ambiente seguro para testes:
- **Máquina virtual configurada como alvo**, que esteja vulnerável ao EternalBlue. Por exemplo:
  - Instale e configure uma VM Windows 7 SP1 ou Windows Server 2008 (sem os patches de segurança aplicados).
  - Um script foi criado para deixar a máquina vulnerável: [Desafio_EternalBlue](https://github.com/HackersHiveClub/Cybersecurity-Bash-Essential/tree/650814f8493e21a29eeeddce0e29927870d7b021/Scripts%20Para%20Cybersecurity/Desafio_EternalBlue)
- **Outra máquina com Linux** (como Kali Linux).

### Ferramentas e configurações necessárias:
- **Nmap instalado:**
  - No Linux: Use o comando `sudo apt update && sudo apt install nmap`.
- **Conectividade de rede** entre a máquina de ataque e a máquina-alvo:
  - Configure as VMs na mesma rede, preferencialmente em modo **Bridge**.

### Conhecimentos prévios:
- Fundamentos de redes (endereço IP, portas).
- Noções básicas de segurança e vulnerabilidades.

---

## Dicas para Realizar o Desafio

### 1. Entenda o Objetivo do Script
- **O que ele faz:** O script usa o Nmap para verificar se um servidor está vulnerável à falha EternalBlue (MS17-010).
- **Como ele funciona:**
  - Verifica se o Nmap está instalado.
  - Valida se o usuário forneceu o endereço IP como argumento.
  - Executa o Nmap com o script NSE `smb-vuln-ms17-010` para varrer a porta 445.
  - Mostra os resultados da varredura no terminal.

---

### 2. Valide Cada Comando Individualmente
Antes de usar o script completo, execute cada comando manualmente no terminal para entender como funcionam:
- **Verificar instalação do Nmap:**
  ```bash
  command -v nmap


