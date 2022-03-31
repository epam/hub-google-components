#!/bin/bash -e

if test ! -d .venv; then
    python3 -m venv .venv
    # shellcheck disable=SC1091
    source .venv/bin/activate
    pip3 install --upgrade pip
else
    # shellcheck disable=SC1091
    source .venv/bin/activate
fi

if test ! -x locust; then
    pip3 install "locust==2.8.4"
fi

expected="200"
success=""
cat << EOF

Waiting when $HOST becomes available (expected http code: $expected)
in the progress printing first letter of http response
where: 0: not available, 2: OK, 4: HTTP error, 5: service error

EOF
# 120 * 5 = 600sec
for _ in $(seq 120); do
    # shellcheck disable=SC1083
    code="$(curl -kLs --write-out %{http_code} --output /dev/null "$HOST")"
    if test "$code" = "$expected"; then
        success="1"
        echo " done!"
        break
    fi
    echo "$code" | head -c1
    sleep 5
done
if test -z "$success"; then
    color w " Timed out!"
fi

echo
locust --config locust.conf

cat << EOF

Outputs:

test_report = "$(pwd)/test_result.html"

EOF

