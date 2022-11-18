FROM eosio/eosio:release_2.1.x
WORKDIR /IDBlock

# Install dependencies
RUN apt-get update
RUN apt-get install -y wget git build-essential cmake --no-install-recommends
RUN rm -rf /var/lib/apt/lists/*

# Install eosio.cdt
RUN wget https://github.com/eosio/eosio.cdt/releases/download/v1.8.1/eosio.cdt_1.8.1-1-ubuntu-18.04_amd64.deb
RUN apt install ./eosio.cdt_1.8.1-1-ubuntu-18.04_amd64.deb

# Declare eosio key
ARG idbotic_eosio_private_key
ARG idbotic_eosio_public_key
ENV IDBOTIC_EOSIO_PRIVATE_KEY $testnet_eosio_private_key
ENV IDBOTIC_EOSIO_PUBLIC_KEY $testnet_eosio_public_key

# Download from IDBOTIC
RUN git clone --branch master https://github.com/adolfommoyano/ID.git
COPY ./genesis_start.sh ./
COPY ./start.sh ./
COPY ./config.ini ./config/
COPY ./genesis.json ./


#Permissions for execute
RUN chmod +x ./genesis_start.sh
CMD ["./genesis_start.sh"]
