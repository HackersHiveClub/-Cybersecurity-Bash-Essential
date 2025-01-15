#!/bin/bash

# Scanner de hosts

IP=$1
echo "Validando o endereço IP $@" 
ping -c 3 $IP

