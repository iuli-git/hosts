#!/bin/bash

verifica_host() {
    local host_name="$1"
    local expected_ip="$2"
    local dns_server="$3"

    local real_ip
    real_ip=$(nslookup "$host_name" "$dns_server" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)

    if [ -n "$real_ip" ] && [ "$real_ip" != "$expected_ip" ]; then
        echo "Eroare IP pentru $host_name: gasit $real_ip, asteptat $expected_ip"
    fi
}

DNS="8.8.8.8"

while read -r ip name; do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    if [ -n "$name" ]; then
        verifica_host "$name" "$ip" "$DNS"
    fi
done < /etc/hosts




echo Ben
