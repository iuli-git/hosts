#!/bin/bash

cat /etc/hosts | while read -r ip name; do
	[[ -z "$ip" || "$ip" =~ ^# ]] && continue

	if [ -n "$name" ]; then
		real_ip=$(nslookup "$name" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)

		if [ -n "$real_ip" ] && [ "$real_ip" != "ip" ]; then
			echo "Bogus IP for $name in /etc/hosts!"
		fi
	fi
done
