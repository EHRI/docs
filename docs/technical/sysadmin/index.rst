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
