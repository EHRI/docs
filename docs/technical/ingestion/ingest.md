Ingest
======
To ingest the harvested metadata into the portal, 

| |location|
|----|-----------------|
|download| https://github.com/EHRI/10.3-ingest-tool
|installation | /var/opt/ingestion1.1|
|config files |  |


configuration
-------------
 * property files
 * records location

During ingest the fields in the EAD files are mapped to the corresponding properties in the graph database. Property files are used for this, they can be tweaked for each source CHI. By default the `generic.properties` are used.

 
run script
----------
`/var/opt/ingestion1.1/run.bash`
Running this will start a start a service on localhost:<port> with a GUI