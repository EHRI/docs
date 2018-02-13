Setting up the development environment
======================================

Prerequisites
-------------

For development, you need a version of the EHRI Neo4j REST server
installed both as libraries and running standalone. This can be done by
following the instructions
`here <https://github.com/mikesname/ehri-rest/blob/master/docs/INSTALL.md>`__.

Install and set up Solr
~~~~~~~~~~~~~~~~~~~~~~~

Download Solr and extract it to the location of your choice (using
~/apps for this example):

.. code-block:: bash

    export SOLR_VERSION=6.4.0
    curl -0 http://mirrors.ukfast.co.uk/sites/ftp.apache.org/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz | tar -zx -C ~/apps
    export SOLR_HOME=~/apps/solr-$SOLR_VERSION

For now, re-use the example Solr core (named "collection1", inside the
example/solr direction). As a shortcut, you can just grab the
``schema.xml`` and ``solrconfig.xml`` from the `ehri-search-tools <https://github.com/EHRI/ehri-search-tools>`_ repository on Github:

.. code-block:: bash

    curl https://rawgithub.com/EHRI/ehri-search-tools/solr-config/master/core/conf/schema.xml > $SOLR_HOME/example/solr/collection1/conf/schema.xml
    curl https://rawgithub.com/EHRI/ehri-search-tools/solr-config/master/core/conf/solrconfig.xml > $SOLR_HOME/example/solr/collection1/conf/solrconfig.xml

If you have an issue with dependencies :

.. code-block:: bash

    mkdir $SOLR_HOME/example/solr/lib
    ln -s $SOLR_HOME/contrib/analysis-extras/lib/*.jar $SOLR_HOME/example/solr/lib/
    ln -s $SOLR_HOME/contrib/analysis-extras/lucene-libs/*.jar $SOLR_HOME/example/solr/lib/
    ln -s $SOLR_HOME/contrib/langid/lib/*.jar $SOLR_HOME/example/solr/lib/
    ln -s $SOLR_HOME/dist/*.jar  $SOLR_HOME/example/solr/lib/

You should now able able to start the Solr server in another shell:

.. code-block:: bash

    cd $SOLR_HOME/example
    java -jar start.jar

If that starts without spewing out any dodgy-looking stack traces all
should be well. You can verify this by going to
http://localhost:8983/solr which should display the Solr admin page.


Installing Play 2.6.x:
~~~~~~~~~~~~~~~~~~~~~~

First of all `install SBT <https://www.scala-sbt.org/1.0/docs/Setup.html>`_ on your system.

Setting up the development code:
--------------------------------

Next, download the source from Github:

.. code-block:: bash

    cd ~/dev
    git clone https://github.com/EHRI/ehri-frontend.git

Start the dependency download process (which usually takes a while):

.. code-block:: bash

    cd ehri-frontend
    play clean compile

PostgreSQL - DB instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Install via your favourite method. Note that on some OS X versions,
Postgres can be a bit fiddly because the one installed by brew conflicts
with the bundled default:

.. code-block:: bash

    sudo apt-get install postgresql-9.5

Now we need to create an empty user and database for our application.
The user and database will have the same name (docview). Start the
Postgres shell (run as the postgres user):

::

    sudo su postgres -c psql

Now, **in the psql shell**, type the following commands (replacing the
password with your password):

::

    CREATE USER docview WITH PASSWORD '<PASSWORD>';
    CREATE DATABASE docview;
    GRANT ALL PRIVILEGES ON DATABASE docview TO docview;

There are some settings on the ``conf/application.conf`` file you can adjust
if you change any of the defaults.

===============================================================================

Back to Solr
------------

One setting you definitely should change is the value of the
``solr.path`` key, which needs to be changed to whatever the path to the
Solr core is. Since the one we set up above used the default
"collection1" name, adjust the setting to match this:

::

    solr.path = "http://localhost:8983/solr/collection1"

Start Neo4j server, if you haven't already:

.. code-block:: bash

    $NEO4J_HOME/bin/neo4j start

Also start Solr, if you didn't already:

.. code-block:: bash

    cd $SOLR_HOME/example
    java -jar start.jar

We can now see if the app actually works:

.. code-block:: bash

    sbt run

Now, after letting it compile, visit http://localhost:9000 in your browser. The app should show a
screen saying it needs to apply a migration to the database. **Click the
"Apply This Script Now" button.**

**TODO: Fix this section which is now outdated.**

Next, we have a little problem because we need to create the login
details of our administrative user in the authorisation database.
Unfortunately there is no way at present to do this without mucking with
the database directly.

Basically, we need to create a database entry that links the default
username you created in Neo4j to an email address (the email address is
a key that identifies a user.)

So open up the PostgreSQL console again:

::

    sudo su postgres -c "psql docview"

First, **in the DB shell**, double check there is no existing user
and/or email:

::

    SELECT * FROM users;

.. code:: sql

    psql> select * from users;
     id | email | verified | staff | active | allow_messaging | created | last_login | password | is_legacy 
    ----+-------+----------+-------+--------+-----------------+---------+------------+----------+-----------
     (0 rows)

Now add one corresponding to your user + email:

.. code:: sql

    psql> INSERT INTO users (id, email, verified, staff, active)
                 VALUES ('example', 'example@example.com', TRUE, TRUE, TRUE);
    INSERT 1 0

**Now log in via OpenID for the email you just created**. The
application will notice that there is already a corresponding email in
the database and, if the OpenID auth succeeds, add an OpenID associate
to the account.

Once logged in to the app you should have full admin privileges. You can
try using an OpenID email account that has not been *pre set up* and the
application will create you a default account with no privileges.

The first thing to do when logging in is to build the search index. This
can be done by going to the `index update page <http://localhost:9000/admin/updateIndex>`_
and checking all the boxes. With luck, or rather, assuming Solr is
configured property, the search index should get populated from the
Neo4j database.
