#!/bin/bash
set -e

source bin/ec2-env.sh


if [ -z "$1" ]
    then
        IP_ADDRESS=`bin/get-ip-ec2-instance.sh`
    else
        IP_ADDRESS=$(bin/get-ip-ec2-instance.sh $1)
fi

if [ -z "$2" ]
    then
        DNS_NAME="$CASSANDRA_DNS_NAME"
    else
        DNS_NAME=$2
fi


echo "IP ADDRESS $IP_ADDRESS $DNS_NAME"

REQUEST_BATCH="
{
\"Changes\":[
    {
        \"Action\": \"UPSERT\",
        \"ResourceRecordSet\": {
                \"Type\": \"A\",
                \"Name\": \"$DNS_NAME\",
                \"TTL\": 300,
                \"ResourceRecords\": [{
                    \"Value\": \"$IP_ADDRESS\"
                }]
        }
    }
]
}
"

echo "$REQUEST_BATCH"

changeId=$(aws route53 change-resource-record-sets --hosted-zone-id "$HOSTED_ZONE_ID" --change-batch "$REQUEST_BATCH" \
| jq --raw-output .ChangeInfo.Id)

aws route53 wait resource-record-sets-changed --id "$changeId"

