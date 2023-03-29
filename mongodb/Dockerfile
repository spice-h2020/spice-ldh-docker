FROM mongo:4.0.28

# File Author / Maintainer
LABEL maintainer="Jason Carvalho https://github.com/JaseMK"
LABEL version="1.0"
LABEL description="SPICE LDH MongoDB image."

ARG MONGO_INITDB_ROOT_USERNAME
ARG MONGO_INITDB_ROOT_PASSWORD
ARG MONGO_INITDB_DATABASE

ADD mongodb-init.js /docker-entrypoint-initdb.d/
ADD mongodb-roles.js /docker-entrypoint-initdb.d/
