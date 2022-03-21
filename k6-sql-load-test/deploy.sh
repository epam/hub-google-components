#!/bin/bash

xk6 build master --with github.com/imiric/xk6-sql
./k6 run "$TEST_NAME-$KIND.js" --duration "$DURATION" --vus "$USERS"
