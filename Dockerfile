FROM python

#Install git
RUN apt-get update && \
    apt-get install -y git && \
    pip install Flask && \
    pip install pandas && \
    pip install pickle5 && \
    pip install scikit-learn && \
    pip install joblib && \
    pip install enstop

    # && apt-get install -y pip3
    # && apt-get install -y flask\
    # && apt-get install -y panda\
    # && apt-get install -y pickel\
    # && apt-get install -y sklearn

#Change directory and clone DCM Public ghe repo
RUN mkdir /usr/dcm \
    && cd /usr/dcm \
    && git clone https://github.com/Purende/document-classification-test.git
    
#Set working directory
RUN chmod +x /usr/dcm/document-classification-test/app.py
WORKDIR /usr/dcm/document-classification-test/
ENTRYPOINT /usr/dcm/document-classification-test/app.py
EXPOSE 5000
