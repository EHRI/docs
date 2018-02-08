Staging Server
==============

EHRI uses a staging server to test bulk data ingests meet requirements before running them on production. Staging is
also used to test various other things and is periodically refreshed from the production database.

Restoring a fresh staging instance from production
--------------------------------------------------

This is a multi-step process:

1. take a copy of the PostgreSQL database
2. take a copy of the Neo4j database
3. stand up each of them on the staging instance
4. rebuild the search index

TODO more docs on this awkward process, and the script to make it easier.
