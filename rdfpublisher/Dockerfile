FROM openjdk:11
ARG PUBLISHER_VERSION
LABEL description="SPICE LDH RDF Publisher"

# Not currently using 'PUBLISHER_VERSION' due to version vs jar file naming inconsistency in github repo
RUN wget https://github.com/spice-h2020/rdf.uploader/releases/download/v0.3.5.pr2/spice.rdf-uploader-v0.3.5.jar 

COPY config.properties .
COPY blazegraph.properties .
COPY timestamp ./tmp/timestamp

CMD ["java", "-jar", "spice.rdf-uploader-v0.3.5.jar"]