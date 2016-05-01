FROM debian:wheezy

ADD package.zip.enc /home

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
	echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list && \
	apt-get update -y && \
	apt-get install less lftp ssh s3cmd wget zip unzip vim openssl mongodb-org-shell mongodb-org-tools mysql-client -y && \
	apt-get clean

ENTRYPOINT cd /home && \
	openssl enc -d -aes-256-cbc -in package.zip.enc -out package.zip -pass pass:$UNLOCK_KEY && \
	unzip package.zip && \
	mv /home/package/_s3cfg /root/.s3cfg && \
	mv /home/package/lftp.conf /etc/lftp.conf && \
	cd /home && \
	/bin/bash
	
	