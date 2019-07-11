Harvesters
==========

For the data integration we first need to get the data on the server. We use two kind of harvesters: an open source harvester that follows the OAI-PMH protocol, [shell-oaiharvester](https://github.com/wimmuskee/shell-oaiharvester). Within the project some institution did not provide a PMH endpoint. We developed a harvester for the [ResourceSync Framework](http://www.openarchives.org/rs/toc), which can be found at the EHRI github [resydes repository](https://github.com/EHRI/resydes). 

OAI-PMH
-------

Download
  ``https://github.com/wimmuskee/shell-oaiharvester``
Installation:
  ``/opt/shell-oaiharvester/``
Config file:
  ``/opt/shell-oaiharvester/config.xml``
Records:
  ``/var/opt/oai-pmh-harvester/``

in the config.xml the harvester needs to be configured, for every endpoint at least the following properties can be set:

 * id - the identifier for this repository, to be used to run the harvester
 * baseurl - the OAI-PMH endpoint of the CHI
 * metadataprefix - the PMH metadataprefix, usually something like `oai_ead` 
 * recordpath - the location to store the records
 * set (optional) - the PMH set to be harvested

`./oaiharvester -c config.xml -r <repository-id>`

this will run the harvester and retrieve all new and updated records from `<repository-id>` and store them at the `recordspath`. There they will be picked up by the ingest-process.

ResourceSync

Download:
  https://github.com/EHRI/resydes
Installation:
  ``/opt/oai-resourcesync/``
Config files:
  ``/opt/oai-resourcesync/cfg/``
Records:
  ``/var/opt/oai-rs-harvester/``

The ResourceSync Framework describes a protocol to a destination (EHRI) in sync with a source (the CHI). It uses sitemaps to do so. In the config file `uri-list.txt` every sitemap is listed that needs to be synced. The `syncapp-context.xml` configures the harvester, for instance the `baseDirectory` to store the retrieved files can be set here.

`/opt/oai-resourcesync/run.sh`

this will run the harvester and retrieve all new and updated files from the CHI and store them at the `baseDirectory`. It will also delete files that are no longer exposed at the CHI. 

Selective Harvesting
--------------------

[selective harvesting](https://github.com/EHRI/ehri-rest/blob/master/ehri-io/src/main/resources/selective-harvest.py)
