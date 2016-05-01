#!/bin/bash

cd /home &&
openssl enc -d -aes-256-cbc -in package.zip.enc -out package.zip -pass pass:$UNLOCK_KEY &&
unzip package.zip && 
mv /home/package/_s3cfg /root/.s3cfg && 
mv /home/package/lftp.conf /etc/lftp.conf && 
/bin/bash $@