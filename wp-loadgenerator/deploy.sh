#!/bin/bash -e

URL="https://$DOMAIN_NAME"

python3 -m venv .venv
# shellcheck disable=SC1091
source .venv/bin/activate
pip3 install --user "locust==2.8.4"

success=""
echo "Waiting when $URL becomes available"
echo "Printing first letter of http response"
echo -n "Where: 0: not available, 2: OK, 4: HTTP error, 5: service error: " 
expected="200"
# 120 * 5 = 600sec
for _ in $(seq 120); do
    # shellcheck disable=SC1083
    code="$(curl -kLs --write-out %{http_code} --silent --output /dev/null "$URL")"
    if test "$code" = "$expected"; then
        success="1"
        echo " done!"
        break
    fi
    echo "$code" | head -c1
    sleep 5
done
echo
if test -z "$success"; then
    color w "Warning: timed out to wait "
fi

locust --config locust.conf
