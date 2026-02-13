Example Ingest
==============

.. role:: alert-danger

:alert-danger:`Note: this method of importing EAD is deprecated in favour of using the` `EAD Manager <../../administration/institution-data/index.html>`__.

The current ingest procedure is somewhat long-winded and technical. This
is an example given a single EAD XML file containing a large number
(48,000) of individual documentary unit items in a single fonds. The
repository is the Internation Tracing Service (ITS), which has EHRI
repository ID ``de-002409``.

This ingest covers importing the EAD file into the staging server, at
which time it should be ready for verification and if necessary,
changes, before the production ingest.

Before you start
----------------

First, log into the EHRI staging server via SSH and open a bunch of
shells. In one of them, tail the following file, which will give us some
information about what goes wrong, when something inevitably goes wrong
the first few times we try:

::

    tail -f /var/log/neo4j/neo4j.log

Back up the database
~~~~~~~~~~~~~~~~~~~~

The Neo4j DB lives in /opt/neo4j/data/databases/graph.db. You
can back it up without shutting down the server by running the
``online-clone-db`` Fabric script, or running:

::

    /opt/neo4j/current/bin/neo4j-admin backup --from localhost:6362 --name=my-backup --backup-dir /tmp/my-backup

To restore the DB the procedure is: - shut down Neo4j - replace
/opt/neo4j/data/databases/graph.db with backup directory you
specified previously - ensure all files in the graph.db directory are
owned and writable by the ``webadm`` group: - chgrp -R webadm graph.db -
chmod -R g+rw graph.db - restart Neo4j

Procedure
---------

Onwards with the ingest...

Next, in another shell, copy the file(s) to be ingested to the server
and place them in ``/opt/neo4/data/import-data/de/de-002409``, the
working directory for ITS data.

.. note::

   Import data is now stored on an S3-compatible object store. This documentation
   is for example purposes only.

Import properties handle certain mappings between tags (with particular
attributes) and EHRI fields. The ITS data has a particular mapping
indicating that when the ``<unitid>`` has a ``type="refcode"`` that is
the main doc unit identifier, and that the rest are the alternates. This
file is, in this case:

::

    /opt/neo4/data/import-data/de/de-002409/its-pertinence.properties

The actual import is done via the /ehri/import/ead endpoint on the Neo4j
extension. It is documented here:
http://ehri.github.io/docs/api/ehri-rest/ehri-extension/wsdocs/resource\_ImportResource.html

The basic procedure is:

-  obtain an appropriate import properties file (which we've done in
   this case)
-  write an appropriate log file, describing what we're doing
-  stick the EAD XML on the server
-  run a curl command, POSTing the XML data to the ingest endpoint, with
   the appropriate parameters
-  re-index the data held by our repository (ITS, de-002409) to make it
   searchable in the portal UI

To make the curl command less cumbersome, lets export the path to the
properties file as an environment variable:

::

    export PROPERTIES=/opt/neo4/data/import-data/de/de-002409/its-pertinence.properties

Also, lets write a log file and export it's path as an environment
variable:

::

    echo "Importing ITS data with properties: $PROPERTIES" > LOG.txt
    export LOG=`pwd`/LOG.txt

Now we can POST the data to the ingest endpoint:

::

    curl -XPOST \
        -H "X-User:mike" \
        -H "Content-type: text/xml" \
        --data-binary @KHSK_GER.xml \
        "http://localhost:7474/ehri/import/ead?scope=de-002409&log=$LOG&properties=$PROPERTIES&commit=true"

These parameters are:

-  the ``X-User`` header tells the web service which user is responsible
   for the ingest.
-  the ``Content-type`` header tells it to expect XML data.
-  the ``scope=de-002409`` query parameter tells it we're importing this
   EAD into the ITS repository.
-  the ``log=$LOG`` parameter tells it to find the log text in a local
   file.
-  the ``properties=$PROPERTIES`` parameter tells it to file the import
   properties in a local file.
-  the ``commit=true|false`` parameter tells the web service to actually
   commit the transaction. By default it will not, which provides a way
   of doing "dry run" ingests.

**Note**: when importing a single EAD containing ~50,000 items in a
single transaction the staging server might run out of memory. If it
does the only option is to increase the Neo4j heap size by uncommenting
and setting the ``dbms.memory.heap.max_size=MORE_MB`` (say, 3500) in
``/etc/neo4j/neo4j.conf`` and restarting Neo4j by running:

::

    sudo service neo4j-service restart

**Additional note**: *Certain date patterns are fuzzy parsed by the
importer and invalid dates such as 31st April will currently throw a
runtime exception resulting in a BadRequest from the web service. So fix
all these first* ;)

If all goes well you should get something like this:

::

    {"created":48430,"unchanged":0,"message":"Import ITS 0.4 data using its-pertinence.properties.\n","updated":0,"errors":{}}

In theory, that ingest should be idemotent, so you can run the same
command again and not change anything. Instead you'd get a reply like:

::

    {"created":0,"unchanged":48430,"message":"Import ITS 0.4 data using its-pertinence.properties.\n","updated":0,"errors":{}}

Indexing
--------

The final step is the re-index the ITS repository, making the items
searchable. This can be done from the Portal Admin UI.

Updating existing collections
-----------------------------

To update existing collections, when, for example, adding descriptions
in another language, the procedure is exactly the same with one
exception: the import Curl command needs an additional parameter:

::

    &allow-update=true

Without this parameter the importer will throw a mode violation error
when it ends up updating an existing collection.

Overwriting existing descriptions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to overwrite existing item description with data from a new
EAD the EAD must have the same ``sourceFileId`` value as exists on the
current description. The ``sourceFileId`` is a property computed from
two aspects of the EAD file: the ``eadheader/eadid`` value and the
``eadheader/profiledesc/langusage/language/@langcode`` value combined
thus: ``[EADID]#[UPPER-CASE-LANGCODE]``.

For example, if the ``eadid`` is ``100`` and the language code is
``eng``, the ``sourceFileId`` will be ``100#ENG``.

Only documentary unit descriptions created via the EAD ingest process
will have a ``sourceFileId``; those created using the portal interface
will not. For descriptions that have the property it is visible (but not
editable) on the portal admin pages.

**Note:** the consequence of the above is that the ``eadid`` value
should **not** contain the language code, since this is redundant and
will result in a ``sourceFileId`` like ``eng#ENG``.

Ingesting multiple files in an archive
--------------------------------------

It is possible to ingest multiple EAD files in a single transaction by
providing the importer with an archive file (containing multiple XML
files) instead of a single XML file. Currently the following formats are
supported:

-  zip (although some extensions are problematic)
-  tar
-  tar.gz

The importer will assume the data it is given is an archive if the
content type of the request is given as ``application/octet-stream``
(aka, miscellaneous binary) instead of either ``text/xml`` (XML) or
``text/plain`` (local file paths.)

**Note**: if several EAD files provide different translations of the
same items it is necessary to enable update ingests via
``&allow-updates=true``.
