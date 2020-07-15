#!/bin/sh

HA_PROXY_DIR=/usr/local/etc/haproxy
LE_DIR=/etc/letsencrypt/live
rm -f ${LE_DIR}/README

DOMAINS=$(ls ${LE_DIR})

# update certs for HAProxy
for DOMAIN in ${DOMAINS}; do
    cat ${LE_DIR}/${DOMAIN}/fullchain.pem ${LE_DIR}/${DOMAIN}/privkey.pem > ${HA_PROXY_DIR}/certs.d/${DOMAIN}.pem
done

# restart HAProxy
exec /usr/bin/haproxy-restart
