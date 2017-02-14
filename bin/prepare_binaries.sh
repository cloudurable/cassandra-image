#!/bin/bash
set -e

export ADVANTAGEOUS_GITHUB_HOME=https://github.com/advantageous

downloadAndVerify() {

    githome=$1
    app=$2
    version=$3
    wget "${githome}/${app}/releases/download/${version}/${app}_linux"

    export CHECKSUM=`shasum ${app}_linux`
    export CHECKSUM_CHECK=`cat checksums/${app}_linux.sha`


    if [ ! "$CHECKSUM" = "$CHECKSUM_CHECK" ]; then

        echo "Check sums did not match"
        echo "GOT $CHECKSUM"
        echo "EXPECTED $CHECKSUM_CHECK"
        exit 128
    fi


    echo "CHECKSUM VALID for ${app}"
    echo "Moving binary ${app}"

    mkdir -p resource/opt/cloudurable/bin
    mv "${app}_linux" "resources/opt/cloudurable/bin/${app}"
    chmod +x "resources/opt/cloudurable/bin/${app}"

}


downloadAndVerify "$ADVANTAGEOUS_GITHUB_HOME" systemd-cloud-watch "v0.2.1"
downloadAndVerify "$ADVANTAGEOUS_GITHUB_HOME" metricsd "0.3"









