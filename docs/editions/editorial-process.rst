*****************
Editorial Process
*****************

The EHRI set of tools was designed, based on real experience and
established standards, to support the full editorial process in
preparation of digital (online) editions. The particular goals included
specification for coding of references to EHRI controlled vocabularies
and collection descriptions in document texts, as well as development of
a user interface which would allow for publication of the documents
along with search capability and projection of the documents on map.

The requirements for the EHRI editions software were driven by the
real-world editorial process starting once the relevant documents have
been selected, transcribed and (where applicable) translated. The
process, as applied in EHRI, consists of the following steps:

1) Annotation using controlled vocabularies:
    EHRI editions put
    emphasis on using links to established controlled vocabularies (EHRI
    for Holocaust-related entities; Geonames for geographic information,
    etc.) as much as possible. The annotation of documents, a core
    element in every documentary edition, therefore should primarily
    consist of tagging words or expressions in texts and linking them to
    controlled vocabularies. Practically, the annotation of documents was
    done in common text editors, for instance in Google Docs; the
    identified entities were tagged as links whereby URLs served as
    unique identifiers in the respective vocabularies.

2) Conversions to TEI and enriching TEI headers
    Once annotation and
    text editing is finalised, the documents are converted to the TEI XML
    format. EHRI team used an open source tool Odette for this purpose
    and extended its stylesheet to recognise the types of entities and
    encode them accordingly based on the URLs used as references (for
    instance a Geonames URL results into application of a <placeName>
    element). The TEI files produced in this way had to be checked by
    editors and cleansed of remaining unwanted formatting. Separate TEI
    (“local dictionary”) is created to list keywords, people, places and
    organisations, which are not included in the EHRI portal or any other
    established controlled vocabulary. An EHRI TEI enrichment utility
    creates normalised entries for linked entities in the TEI Header
    which are later used to drive the faceted browse and map
    visualisations. Editors can edit these normalised records and add new
    ones as needed for the purpose of the particular edition.

3) Ingest to the frontend application (Omeka):
    The resulting TEI
    documents are uploaded to the Omeka web publication platform and
    populate the database based on a mapping. Interactive map
    presentations are created based on the TEI data to make easier
    spatial reading of the document.

