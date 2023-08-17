#!/bin/bash

declare -a domains
declare -a certnames
# ---------------------------------------------------------------------------

source ./domains.conf

# ---------------------------------------------------------------------------

for key in "${!domains[@]}"
do
	domain=${domains[$key]}
	name=${certnames[$key]}
	SUBJECT="/C=RU/ST=Moscow/L=Moscow/O=Example-Certificates"
	DOMAIN_EXT="authorityKeyIdentifier=keyid,issuer\nbasicConstraints=CA:FALSE\nkeyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment\nsubjectAltName = @alt_names\n[alt_names]"
	I=1
	for host in ${domain}; do
		SUBJECT="${SUBJECT}/CN=${host}";
		DOMAIN_EXT="${DOMAIN_EXT}\nDNS.${I} = ${host}"
		I=$((I+1));
	done
	if [ ! -d "${name}" ]; then
		mkdir ${name}
		
		echo -e ${DOMAIN_EXT} > ${name}/${name}.ext
		
		openssl req -new -nodes -newkey rsa:2048 -keyout ${name}/${name}.key -out ${name}/${name}.csr -subj "${SUBJECT}"
		openssl x509 -req -sha256 -days 1024 -in ${name}/${name}.csr -CA root_ca.crt -CAkey root_ca.key -CAcreateserial -extfile ${name}/${name}.ext -out ${name}/${name}.crt
		cp ./root_ca.pem ${name}/

		rm -rf ${name}/${name}.csr
		rm -rf ${name}/${name}.ext
	fi
	

done
