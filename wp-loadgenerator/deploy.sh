#!/bin/bash

URL="https://$DOMAIN_NAME"

python3 -m venv .venv
source .venv/bin/activate
pip3 install -r requirements.txt

TIMEOUT=600
ATTEMP=0
while test "$(curl --write-out %{http_code} --silent --output /dev/null "$URL")" != "200"
do
    ATTEMP=$((ATTEMP + 1))
    echo "Wait while $URL become available... $(($ATTEMP * 5)) sec"
    if [ "$ATTEMP" == "$TIMEOUT" ]; then
        echo "Timeout Error";
    fi
    sleep 5
done

locust -f locustfile.py --users "$USERS_COUNT" --host "$URL" --headless --spawn-rate "$SPAWN_RATE" --run-time "$RUN_TIME" --exit-code-on-error 0
