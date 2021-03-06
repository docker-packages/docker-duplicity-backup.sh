
#!/bin/bash

cat <<EOF > /home/duplicity/.s3cfg
$([ "$(echo "$DEST" | cut -d'/' -f1)" == "s3:" ] && echo "host_base = $(echo "$DEST" | cut -d'/' -f3)")
$([ "$(echo "$DEST" | cut -d'/' -f1)" == "s3:" ] && echo "host_bucket = $(echo "$DEST" | cut -d'/' -f3)")
bucket_location = ${BUCKET_LOCATION:-us-east-1}
use_https = True
access_key = ${AWS_ACCESS_KEY_ID}
secret_key = ${AWS_SECRET_ACCESS_KEY}
signature_v2 = False
EOF

/usr/local/bin/duplicity-backup.sh -c /home/duplicity/dulicity-backup.conf "$@"
