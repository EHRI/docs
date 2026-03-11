CSV Import
==========

Importing CSV data was added to the Import Manager in March 2026 and is not yet a fully-
developed feature. Currently, you can upload CSV but you can't transform it, and imported
data must stick to a very specific format. The tabular data must:

* contain a header row
* be comma-delimited
* be quoted with double-quotes (") if fields contain commas
* use the backslash as an escape character for quote characters within strings
* use a double pipe (||) to separate array values within a column value

The headers should correspond to some or all of the following columns:

objectIdentifier
  Mandatory: Contains the local identifier of the archival unit

name
  The title of the archival unit

levelOfDescription
  The level of description, e.g. fonds, series, file, item

sourceFileId
  An identifier for the source of the description, to be used to
  disambiguate from other parallel descriptions of the same item

ref
  The web-accessible URL of the archival description, if one exists

languageCode
  The ISO-639-2 3-letter language code denoting the language used
  in the description itself (not the material)

languageOfMaterial
  The ISO-639-2 3-letter language codes denoting the language(s) used
  in the material itself

The following fields are self explanatory and correspond to ISAD(G):

* appraisal
* archivalHistory
* archivistNote
* biographicalHistory
* extentAndMedium
* findingAids
* rulesAndConventions
* scopeAndContent
* systemOfArrangement
* relatedUnitsOfDescription
* separatedUnitsOfDescription
* sources


