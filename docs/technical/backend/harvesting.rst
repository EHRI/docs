Harvesting
==========

To ingest the harvested metadata into the portal, 


Locations
---------

Download:
  https://github.com/EHRI/10.3-ingest-tool

Installation:
  ``/var/opt/ingestion1.1``

Config files:
  ``/var/opt/.EHRI/``


Configuration
-------------

The ingest uses a json configuration per data collection, which is usually all the files belonging to one institution. These can be found in `/var/opt/.EHRI/`.

This configuration deals with the following:

 * ``name`` - human readable identification, usually the name of the CHI
 * ``ingestPropertyFile`` - path to the local mapping file from EAD to graph properties
 * ``repositoryName`` - the identifier in the graph db to which these files need to be ingested
 * ``repository`` - url of the ingest-service to the graph db
 * ``enrichments`` - 
 * ``allowUpdate`` - boolean to indicate whether the changes will be committed
 * ``log`` - path to local log file of this ingest
 * ``tolerant`` - boolean to indicate whether an the ingest should continue after a single invalid item. Use with caution.

NB: ``ingestPropertyFile``: During ingest the fields in the EAD files are mapped to the corresponding properties in the graph database. Property files are used for this, they can be tweaked for each source CHI. By default the `generic.properties` can be used. 

 
Run script
----------

  ``/var/opt/ingestion1.1/run.bash``

Running this will start a start a service on ``localhost:<port>`` with a GUI.
