
FROM python

#Install git
RUN apt-get update \
    && apt-get install -y git

#Change directory and clone DCM Public ghe repo
RUN mkdir /usr/dcm \
    && cd /usr/dcm \
    && git clone https://github.com/Purende/document-classification-test.git
    
#Set working directory
RUN chmod +x /usr/dcm/document-classification-test/app.py
WORKDIR /usr/dcm/document-classification-test/
ENTRYPOINT /usr/dcm/document-classification-test/app.py