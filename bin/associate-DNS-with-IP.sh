#!/bin/bash
set -e

source bin/ec2-env.sh

IP_ADDRESS=`bin/get-IP-CASSANDRA.sh`


REQUEST_BATCH="
{
\"Changes\":[
    {
        \"Action\": \"UPSERT\",
        \"ResourceRecordSet\": {
                \"Type\": \"A\",
                \"Name\": \"$NODE0_DNS\",
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

