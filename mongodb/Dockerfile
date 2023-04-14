FROM mongo:4.0.28

# File Author / Maintainer
LABEL maintainer="Jason Carvalho https://github.com/JaseMK"
LABEL version="1.0"
LABEL description="SPICE LDH MongoDB image."

ARG MONGO_INITDB_ROOT_USERNAME
ARG MONGO_INITDB_ROOT_PASSWORD
ARG MONGO_INITDB_DATABASE

COPY policies_array.json /home

ADD mongodb-init.js /docker-entrypoint-initdb.d/
ADD mongodb-content.js /docker-entrypoint-initdb.d/
ADD monogo-data-script.sh /docker-entrypoint-initdb.d/

# RUN cd /home && mongoimport --db=spice --collection=spice_policies --file=/home/policies_array.json --jsonArray 
# RUN mongoimport --db=spice --collection=spice_policies --file=/home/policies_array.json --jsonArray 
