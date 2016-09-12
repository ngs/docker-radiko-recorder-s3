Radiko Recording Uploader
=========================

Environment Variables
---------------------

```sh
STATION # http://www.dcc-jpl.com/foltia/wiki/radikomemo
DURATION_MINUTES
RADIKO_LOGIN
RADIKO_PASSWORD
S3_BUCKET
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_DEFAULT_REGION
SLACK_WEBHOOK_URL
SLACK_CHANNEL
```

Run It
------

```sh
docker pull atsnngs/radiko-s3:latest
docker run --env-file=.envrc atsnngs/radiko-s3
```


