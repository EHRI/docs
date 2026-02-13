Deployment
==========

**This is a work in progress document.**

The EHRI REST backend is deployed as a Neo4j unmanaged extension. In
practice, this means:

-  it compiles to an "uberjar" (all dependencies in one jar) which live
   in the ``plugins`` directory of a Neo4j installation
-  the following setting in ``neo4j.conf`` maps our Jersey web URIs to a
   path (/ehri):
-  ``dbms.unmanaged_extension_classes=eu.ehri.project.ws=/ehri``

In practice, a set of symlinks are used to allow easier versioning of
releases:

The symlink ``$NEO4J_HOME/plugins/ehri-rest.jar`` points to
``/opt/neo4j/ehri-rest/current``, which is itself a symlink to
``/opt/neo4j/ehri-rest/deploys/ehri-data-[TIMESTAMP]_[GIT-REV].jar``.

When new versions of the EHRI code is released the uberjar is uploaded
to the ``/opt/neo4j/ehri-rest/deploys`` directory, named with the
timestamp and the code's git revision. Then the ``current`` symlink is
updated to point to the new deployment and the Neo4j service restarted.

Using the Fabfile for automated deployment tasks
------------------------------------------------

The ``fabfile.py`` script provides a set of tasks that can be used to
release new versions of the code. Once Fabric (version 2.6.0) has been
installed (typically via ``sudo apt install fabric``) you can view the
available tasks like so:

.. code:: bash

    $> fab --list

    Fabric deployment script for EHRI rest backend.

    Available commands:

        deploy                 Build (optionally with `--clean`) and deploy the distribution
        get-artifact-version   Get the current artifact version from Maven
        get-version-stamp      Get the tag for a version, consisting of the current time and git revision
        latest                 Set the current version to the latest version directory
        online-backup          Create an online backup to directory `dir`
        online-clone-db        Create an online backup of the database and download to local dir `dir`
        restart                Restart the Neo4j process
        rollback               Set the current version to the previous version directory
        symlink-target         Symlink a version directory

More detailed info for tasks are available with the ``--help`` switch followed by the name of the task:

.. code:: bash

    $> fab --help  online-clone-db

        Usage: fab [--core-opts] online-clone-db [--options] [other tasks here ...]

        Docstring:
          Create an online backup of the database and download to local dir `dir`

        Options:
          -d STRING, --dir=STRING

To run the command on a given host, use the -H/--hosts flag, e.g:

.. code:: bash

    $> fab --hosts ehri-neo4j-01,ehri-neo4j-02 deploy --clean