#!/bin/bash

# Verificar se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
    echo "Por favor, execute como root."
    exit 1
fi

# Verificar e instalar netcat, se necessário
if ! command -v nc &> /dev/null; then
    echo "Netcat não encontrado. Instalando..."
    apt-get update
    apt-get install -y netcat
else
    echo "Netcat já está instalado."
fi

# Verificar e instalar vsftpd, se necessário
if ! command -v vsftpd &> /dev/null; then
    echo "vsftpd não encontrado. Instalando..."
    apt-get update
    apt-get install -y vsftpd
else
    echo "vsftpd já está instalado."
fi

# Configurar a porta 80 usando netcat
PORT_80_SCRIPT="/usr/local/bin/simulate_http.sh"
echo "#!/bin/bash" > $PORT_80_SCRIPT
echo "while true; do echo -e 'HTTP/1.1 200 OK\n\nBem-vindo ao servidor HTTP simulado!' | nc -l -p 80; done" >> $PORT_80_SCRIPT
chmod +x $PORT_80_SCRIPT

# Executar o script em background
if ! pgrep -f "simulate_http.sh" > /dev/null; then
    nohup bash $PORT_80_SCRIPT &
    echo "Simulação HTTP iniciada na porta 80."
else
    echo "Simulação HTTP já está rodando."
fi

# Configurar a porta 21 com vsftpd
# Backup do arquivo de configuração original
if [ ! -f /etc/vsftpd.conf.bkp ]; then
    cp /etc/vsftpd.conf /etc/vsftpd.conf.bkp
    echo "Backup do arquivo de configuração do vsftpd criado."
fi

# Configurar o vsftpd
cat <<EOL > /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=YES
local_enable=NO
write_enable=NO
dftpd_banner=Bem-vindo ao FTP Simulado
anon_root=/srv/ftp
no_anon_password=YES
pasv_min_port=30000
pasv_max_port=30100
allow_writeable_chroot=YES
EOL

# Criar diretório para FTP anônimo
mkdir -p /srv/ftp
chmod 755 /srv/ftp
chown nobody:nogroup /srv/ftp

# Reiniciar o serviço vsftpd
systemctl restart vsftpd

# Exibir mensagem de sucesso
echo "Portas 80 (HTTP) e 21 (FTP) estão abertas para coleta de banners."
