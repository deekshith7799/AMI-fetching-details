#!/bin/bash
CONSOLE_USER=71950544-7757-4b13-b1fe-be4c21a7d798
CONSOLE_PASSWORD=gDdEqNRSvLS1Oke/IvLT/jUp7Xs=
CONSOLE_URL=https://us-west1.cloud.twistlock.com/us-3-159181302
TOKEN=$(curl -H "Content-Type: application/json" -d '{"username": "'$CONSOLE_USER'", "password": "'$CONSOLE_PASSWORD'"}' $CONSOLE_URL/api/v1/authenticate --insecure | grep -o '"token":"[^"]*' | cut -d'"' -f4 )
echo $TOKEN
curl -sSL -k --header "authorization: Bearer $TOKEN" -X POST https://us-west1.cloud.twistlock.com/us-3-159181302/api/v1/scripts/defender.sh  | sudo bash -s -- -c "us-west1.cloud.twistlock.com" -d "none"  -m -u
