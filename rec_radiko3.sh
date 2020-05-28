#!/bin/sh

set -eu

USERNAME='Radiko Recorder'
DIR=/var/radiko
TIME=$(date +"%Y-%m-%d-%H_%M")
FNAME="${STATION}_${TIME}.m4a"
OUTFILE="${DIR}/${FNAME}"
mkdir -p $DIR

curl -s -X POST --data-urlencode "payload={\"channel\": \"#${SLACK_CHANNEL}\", \"username\": \"${USERNAME}\", \"text\": \"Started recording ${STATION} for ${DURATION_MINUTES} minutes\"}" $SLACK_WEBHOOK_URL

/usr/local/bin/radi.sh \
  -t radiko \
  -s $STATION \
  -d $DURATION_MINUTES \
  -i $RADIKO_LOGIN \
  -p $RADIKO_PASSWORD \
  -o $OUTFILE

echo "Uploading $FNAME"
aws s3 cp --acl public-read $OUTFILE "s3://${S3_BUCKET}/${FNAME}"
URL="https://${S3_BUCKET}.s3.amazonaws.com/${FNAME}"
curl -s -X POST --data-urlencode "payload={\"channel\": \"#${SLACK_CHANNEL}\", \"username\": \"${USERNAME}\", \"text\": \"Completed recording ${STATION} for ${DURATION_MINUTES} minutes\",\"attachments\":[{\"title\":\"${FNAME}\",\"title_link\":\"${URL}\"}]}" $SLACK_WEBHOOK_URL
