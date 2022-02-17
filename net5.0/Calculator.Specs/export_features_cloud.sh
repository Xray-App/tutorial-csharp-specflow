#!/bin/bash



BASE_URL=https://xray.cloud.getxray.app
KEYS="XT-459"
token=$(curl -H "Content-Type: application/json" -X POST --data @"cloud_auth.json" $BASE_URL/api/v1/authenticate| tr -d '"')
curl -H "Content-Type: application/json" -X GET -H "Authorization: Bearer $token" "$BASE_URL/api/v1/export/cucumber?keys=$KEYS" -o features.zip

rm -rf Features/*.feature Features/*.cs
unzip -o features.zip -d Features
