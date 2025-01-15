#!/bin/bash

# solictar o IP
echo "Digite o IP: "
read ip

ping -c 3 $ip

