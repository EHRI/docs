EHRI System Administration
==========================

These documents describe the current state of system administration for the EHRI sites as of February 2018.

Hosting
-------

EHRI uses cloud VPS systems provided by `Digital Ocean <http://digitalocean.com>`_, primarily because DO provide servers
based in the Netherlands, which was a requirement for EHRI data. 

DO provide team administration for servers, so if your require access ask to be added to the EHRI team.

File Storage
------------

EHRI currently uses AWS S3 for hosting certain data:

- some static assets for the EHRI portal, along with uploadable data such as user profile images
- Omeka media, via the `S3 FileStorage Adapter plugin <https://github.com/EHRI/omeka-amazon-s3-storage-adapter>`_
- Database backups

We principally use the eu-central-1 region to keep data on European servers.

As of 2021 we also use Digital Ocean's Spaces storage service, via its S3-compatible API, for storing file-based metadata for ingest into the portal. These spaces are based in the AMS3 (Amsterdam) data centre.

Ask a member of the EHRI team for access to AWS or DO resources.

Service Monitoring
------------------

EHRI has a `StatusCake <https://www.statuscake.com>`_ account to monitor the availability of the EHRI portal and other services. If you need access to this account, please ask a member of the EHRI team.

There is a (WIP) public status page at `statuscake.ehri-project.eu <https://status.ehri-project.eu>`_ which shows the current status of various public services, including the EHRI portal, Online Edition sites, and the Document Blog.

Backend Service Monitoring
~~~~~~~~~~~~~~~~~~~~~~~~~~

Some individual backend services such as Neo4j, Solr, Elasticsearch, and the Portal are monitored using `Monit <https://mmonit.com/monit>`_. Typically, this tests an HTTP endpoint
and attempts to restart the service a set number of times if it doesn't respond. Usually, a service crashing indicates something amiss that needs to be fixed, such as memory
exhaustion or a misconfiguration, so Monit is only the first line of defence and should not be relied upon to fix problems automatically.

To use Monit to show service status you can run the following command on the server:

.. code-block:: bash

    sudo monit status


Alternately, the log file in `/var/log/monit.log` can be checked for service status and errors. When restart events occur a notification email is sent to the tech-alerts@ forwarding address.

Monitoring Apache and server load
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The first way to check if we're being DDOSed is to check the server load average, which can be done with the `uptime` command or with `htop`. If it's above
about 4.0 then the server is under some unusual load. The next thing to check is requests per second on Apache, which can be determined by running the following
command on the server:

.. code-block:: bash

    sudo apachectl status


