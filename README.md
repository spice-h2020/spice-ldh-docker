# SPICE Linked Data Hub (LDH) -- Docker release

This project includes the final packaged version of the SPICE Linked Data Hub (LDH), developed by the EU-funded project [SPICE](http://spice-h2020.eu), including links to the resources required for setting up an instance of the LDH platform and instructions for deploying new LDH instances. 


For ease of deployment, the LDH and its constituent components are made available here as a series of [Docker](https://www.docker.com/get-started/) containers. 
In what follows, we will cover the steps involved in downloading and running the Docker containers and how to access the resulting LDH services once they are up and running. 

### Installing and running the containers 
Install Docker. If Docker is not already installed on your system, follow the instructions on the [Docker website](https://www.docker.com/get-started/ ) to install it.   

Download the latest version of the SPICE LDH docker environment from its GitHub repository, at https://github.com/spice-h2020/spice-ldh-docker, using the command: 

> git clone https://github.com/spice-h2020/spice-ldh-docker.git  
 

Within the repository directory, build the containers: 

> cd spice-ldh-docker 
> docker compose build 
 

Run the Docker containers: 
> docker compose up 

### Accessing the LDH services 

Once the containers are running, the LDH services are available locally at the following URLs: 

`http://localhost:8091/` - LDH Portal. This is the main LDH web interface. On first install, an admin user is automatically created with the following credentials: 
 
username: admin@example.com 
password: password 
 
Once logged in, additional users can be created. You should start by creating your own administrator user account. Once logged in using this account, you can begin creating datasets and access keys. 

`http://localhost:8090/` - LDH API. Use of this web interface isn’t strictly required, although it is a useful tool for listing all API functions in a single place and providing an interface for testing API calls used in application development. Full documentation on the LDH and its web interface is covered in deliverable D6.8. 
 

`http://localhost:8099/` - LDH graph database (Blazegraph). This is not required for normal LDH use, but the graph database is visible at this address for debugging, inspection and SPARQL query testing purposes. 

### Stopping and starting the services 

Once running, the Docker containers will be shown in the Docker desktop application as green.
The entire SPICE LDH Docker environment can be started and stopped using the start and stop buttons shown in the top-right. 
On the first creation of the containers, blank datasets will be initialised for all the required LDH storage. After this, stopping and starting the containers will persist this storage so data is not lost. Note that deleting and rebuilding the containers will lose the existing data storage and initialise the LDH environment with a new fresh and empty data storage component once again. 

## Software overview
The SPICE Linked Data Hub is made up of a series of software components. These are all made available publicly at the following locations 

LDH API - https://github.com/mkdf/api-factory  

LDH API SPARQL module - https://github.com/mkdf/api-factory-sparql  

LDH portal - https://github.com/spice-h2020/linked-data-hub  

mkdf-core - https://github.com/mkdf/mkdf-core  

mkdf-datasets - https://github.com/mkdf/mkdf-datasets  

mkdf-topics - https://github.com/mkdf/mkdf-topics  

mkdf-stream - https://github.com/mkdf/mkdf-stream  

mkdf-keys - https://github.com/mkdf/mkdf-keys 

mkdf-sparql - https://github.com/mkdf/mkdf-sparql  

mkdf-policies - https://github.com/mkdf/mkdf-policies  

LDH content scanner - https://github.com/spice-h2020/ldh-scanning-framework  

RDF uploader - https://github.com/spice-h2020/rdf.uploader  

SPICE LDH Docker environment - https://github.com/spice-h2020/spice-ldh-docker  

 