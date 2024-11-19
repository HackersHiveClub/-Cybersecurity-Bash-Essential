#!/bin/bash
# Aula sobre condicionais

logfile=/var/log/faillog2

if [ -f "$logfile" ]; then
echo  "O arquivo $logfile existe"
else
echo "O arquivo $logfile não existe"
fi

