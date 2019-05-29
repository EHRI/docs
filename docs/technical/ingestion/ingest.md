Ingest
======
To ingest the harvested metadata into the portal, 

| |location|
|----|-----------------|
|download| https://github.com/EHRI/10.3-ingest-tool
|installation | /var/opt/ingestion1.1|
|config files | /var/opt/.EHRI/ |


configuration
-------------
The ingest uses a json configuration per data collection, which is usually all the files belonging to one institution. These can be found in `/var/opt/.EHRI/`
This configuration deals with the following:

 * name - human readable identification, usually the name of the CHI
 * ingestPropertyFile - path to the local mapping file from EAD to graph properties
 * repositoryName - the identifier in the graph db to which these files need to be ingested
 * repository - url of the ingest-service to the graph db
 * enrichments - 
 * allowUpdate - boolean to indicate whether the changes will be committed
 * log - path to local log file of this ingest
 * tolerant - boolean to indicate of an invalid ingest will terminate the ingest or not. Use with caution

`ingestPropertyFile`: During ingest the fields in the EAD files are mapped to the corresponding properties in the graph database. Property files are used for this, they can be tweaked for each source CHI. By default the `generic.properties` can be used. 

 
run script
----------
`/var/opt/ingestion1.1/run.bash`
Running this will start a start a service on localhost:<port> with a GUI