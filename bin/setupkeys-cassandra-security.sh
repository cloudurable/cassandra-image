#!/bin/bash

set -e

KEY_STORE_PATH="$PWD/resources/opt/cassandra/conf/certs"
mkdir -p "$KEY_STORE_PATH"
KEY_STORE="$KEY_STORE_PATH/cassandra.keystore"
PKS_KEY_STORE="$KEY_STORE_PATH/cassandra.pks12.keystore"
TRUST_STORE="$KEY_STORE_PATH/cassandra.truststore"
PASSWORD=cassandra
CLUSTER_NAME=test
CLUSTER_PUBLIC_CERT="$KEY_STORE_PATH/CLUSTER_${CLUSTER_NAME}_PUBLIC.cer"
CLIENT_PUBLIC_CERT="$KEY_STORE_PATH/CLIENT_${CLUSTER_NAME}_PUBLIC.cer"

rm -f "${KEY_STORE_PATH}/"*
rm -f "$PWD/resources/server/certs/${CLUSTER_NAME}_rsa"
rm -f "$PWD/resources/server/certs/${CLUSTER_NAME}_rsa.pub"

### Cluster key setup.
# Create the cluster key for cluster communication.
keytool -genkey -keyalg RSA -alias "${CLUSTER_NAME}_CLUSTER" -keystore "$KEY_STORE" -storepass "$PASSWORD" -keypass "$PASSWORD" \
-dname "CN=CloudDurable Image $CLUSTER_NAME cluster, OU=Cloudurable, O=Cloudurable, L=San Francisco, ST=CA, C=USA, DC=cloudurable, DC=com" \
-validity 36500

# Create the public key for the cluster which is used to identify nodes.
keytool -export -alias "${CLUSTER_NAME}_CLUSTER" -file "$CLUSTER_PUBLIC_CERT" -keystore "$KEY_STORE" \
-storepass "$PASSWORD" -keypass "$PASSWORD" -noprompt

# Import the identity of the cluster public cluster key into the trust store so that nodes can identify each other.
keytool -import -v -trustcacerts -alias "${CLUSTER_NAME}_CLUSTER" -file "$CLUSTER_PUBLIC_CERT" -keystore "$TRUST_STORE" \
-storepass "$PASSWORD" -keypass "$PASSWORD" -noprompt


### Client key setup.
# Create the client key for CQL.
keytool -genkey -keyalg RSA -alias "${CLUSTER_NAME}_CLIENT" -keystore "$KEY_STORE" -storepass "$PASSWORD" -keypass "$PASSWORD" \
-dname "CN=CloudDurable Image $CLUSTER_NAME client, OU=Cloudurable, O=Cloudurable, L=San Francisco, ST=CA, C=USA, DC=cloudurable, DC=com" \
-validity 36500

# Create the public key for the client to identify itself.
keytool -export -alias "${CLUSTER_NAME}_CLIENT" -file "$CLIENT_PUBLIC_CERT" -keystore "$KEY_STORE" \
-storepass "$PASSWORD" -keypass "$PASSWORD" -noprompt

# Import the identity of the client pub  key into the trust store so nodes can identify this client.
keytool -importcert -v -trustcacerts -alias "${CLUSTER_NAME}_CLIENT" -file "$CLIENT_PUBLIC_CERT" -keystore "$TRUST_STORE" \
-storepass "$PASSWORD" -keypass "$PASSWORD" -noprompt



keytool -importkeystore -srcalias "${CLUSTER_NAME}_CLIENT" -srckeystore "$KEY_STORE" -destkeystore "$PKS_KEY_STORE" -deststoretype PKCS12 \
-srcstorepass "$PASSWORD" -deststorepass "$PASSWORD"

openssl pkcs12 -in "$PKS_KEY_STORE" -nokeys -out "$KEY_STORE_PATH/${CLUSTER_NAME}_CLIENT.cer.pem" -passin pass:cassandra
openssl pkcs12 -in "$PKS_KEY_STORE" -nodes -nocerts -out "$KEY_STORE_PATH/${CLUSTER_NAME}_CLIENT.key.pem" -passin pass:cassandra


ssh-keygen -t rsa -C "your_email@example.com" -N "" -C "setup for cloud" -f "$PWD/resources/server/certs/${CLUSTER_NAME}_rsa"

chmod 700 "$PWD/resources/server/certs/"*

cp "${KEY_STORE_PATH}/"* /opt/cassandra/conf/certs

