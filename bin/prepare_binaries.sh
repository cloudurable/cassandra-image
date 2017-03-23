#!/bin/bash
set -e

export ADVANTAGEOUS_GITHUB_HOME=https://github.com/advantageous
export CLOUDURABLE_GITHUB_HOME=https://github.com/cloudurable

downloadAndVerify() {

    githome=$1
    project=$2
    app=$3
    version=$4
    output_dir=$5

    wget "${githome}/${project}/releases/download/${version}/${app}_linux"

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

    mkdir -p "$output_dir"
    mv "${app}_linux" "${output_dir}/${app}"
    chmod +x "${output_dir}/${app}"

}


#downloadAndVerify "$ADVANTAGEOUS_GITHUB_HOME" systemd-cloud-watch systemd-cloud-watch "v0.2.1" "resources/opt/cloudurable/bin"
downloadAndVerify "$CLOUDURABLE_GITHUB_HOME" metricsd metricsd "0.4.1" "resources/opt/cloudurable/bin"
#downloadAndVerify "$CLOUDURABLE_GITHUB_HOME" cassandra-cloud cassandra-cloud "v0.0.6" "resources/opt/cloudurable/bin"
#downloadAndVerify "$CLOUDURABLE_GITHUB_HOME" cassandra-image apache-cassandra-3.9-bin.tar.gz "v0.1.0" "resources/opt"









