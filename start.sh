#!/bin/bash
DATADIR="./blockchain" 
if [ ! -d $DATADIR ]; then
  mkdir -p $DATADIR;
fi
nodeos \
--genesis-json $DATADIR"/../../genesis.json" \
--signature-provider $IDBOTIC_EOSIO_PUBLIC_KEY=KEY:$IDBOTIC_EOSIO_PRIVATE_KEY\
--plugin eosio::producer_plugin \
--plugin eosio::chain_api_plugin \
--plugin eosio::http_plugin \
--plugin eosio::history_api_plugin \
--plugin eosio::history_plugin \
--data-dir $DATADIR"/data" \
--blocks-dir $DATADIR"/blocks" \
--config-dir $DATADIR"/config" \
--producer-name YOUR_PRODUCER_NAME\
--http-server-address 0.0.0.0:8888 \
--p2p-listen-endpoint 0.0.0.0:4444 \
--access-control-allow-origin=* \
--contracts-console \
--http-validate-host=false \
--verbose-http-errors \
--enable-stale-production \
--p2p-peer-address INSTANCE2_IP:4444 \
--p2p-peer-address INSTANCE3_IP:4444 \
>> $DATADIR"/nodeos.log" 2>&1 & \
echo $! > $DATADIR"/eosd.pid