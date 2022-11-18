#!/bin/bash
DATADIR="./blockchain" 
if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi

#Replace EOS Public Key in genesis.json
sed -i "s/IDBOTIC_EOSIO_PUBLIC_KEY/$IDBOTIC_EOSIO_PUBLIC_KEY/" genesis.json

nodeos \
--genesis-json genesis.json \
--signature-provider $IDBOTIC_EOSIO_PUBLIC_KEY=KEY:$IDBOTIC_EOSIO_PRIVATE_KEY \
--plugin eosio::producer_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::history_api_plugin \
--plugin eosio::history_plugin \
--data-dir $DATADIR"/data" \
--blocks-dir $DATADIR"/blocks" \
--config-dir $DATADIR"/config" \
--producer-name idbotic \
--http-server-address 0.0.0.0:8888 \
--p2p-listen-endpoint 0.0.0.0:4444 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid" 

while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8888/v1/chain/get_info)" != "200" ]]; 
  do
    sleep 1
  done
  echo "====================================== Done genesis ======================================"
}
