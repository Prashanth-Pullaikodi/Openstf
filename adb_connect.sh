#!/usr/bin/env bash
#Script to connect STF api and select any one of the deivice from the list .Connect the selected device usig adb connect command.

STF_URL=$(cat .env|grep STF_URL|awk -F "=" '{print$2}')
STF_TOKEN=$(cat .env|grep STF_TOKEN|awk -F "=" '{print$2}')
#curl -s -H @auth_file.txt $STF_URL/api/v1/devices|jq -r  '.devices[].serial'

#Query STF api and grep only our device from the list
#DEVICE_SERIAL=`curl -s -H "Authorization: Bearer $STF_TOKEN" $STF_URL/api/v1/devices|jq -r  '.devices[].serial'|egrep -i "Galaxy_S10_SERNO|Galaxy_S8_SERNO|Pixel3_SERNO|head -1`

#For now manually assigned the device serail since no working STF API
DEVICE_SERIAL="Galaxy_S10_SERNO"

if [ "$DEVICE_SERIAL" == "" ]; then
    echo "API returned null device serial"
    exit 1
fi

if [ "$STF_URL" == "" ]; then
    echo "Please specify stf url using .env file"
    exit 1
fi

if [ "$STF_TOKEN" == "" ]; then
    echo "Please specify stf token using using .env file"
    exit 1
fi

#Loop for ever ,for 120 times in every 30 seconds and exit if fails else continue

while true
 do
        for i in {1..120};do
                 response=$(curl -s -X POST \
                 -H "Authorization: Bearer $STF_TOKEN" \
                 $STF_URL/api/v1/user/devices/$DEVICE_SERIAL/remoteConnect)

                 success=$(echo "$response" | jq .success | tr -d '"')
                 description=$(echo "$response" | jq .description | tr -d '"')
                
            if [ "$success" != "true" ]; then
                 echo "$DEVICE_SERIAL Failed because $description"
                 exit 1
            else
                 remote_connect_url=$(echo "$response" | jq .remoteConnectUrl | tr -d '"')
                 adb connect $remote_connect_url
                 echo "Device $DEVICE_SERIAL remote connected successfully"
             fi
        done
    sleep 30
done