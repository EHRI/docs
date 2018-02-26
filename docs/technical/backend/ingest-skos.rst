SKOS Ingest
===========

Geonames Example
----------------

The Geonames SKOS dump is a large dataset consisting of Geonames places deemed to be relevant for EHRI.

TODO

    curl -v -H X-User:mike \
        "http://localhost:7474/ehri/import/skos?scope=geonames&commit=true&format=TTL&log=Geonames%20ingest&tolerant=false&suffix=%2F&baseURI=http%3A%2F%2Fsws.geonames.org%2F" \
        --data-binary @ehri_place_export_skos_26.09.17.ttl
