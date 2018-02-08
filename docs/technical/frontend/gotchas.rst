Miscellaneous Gotchas
=====================

JSON deserialisation errors when accessing search pages
-------------------------------------------------------

The number one cause of this is the search engine being out-of-sync with the database, with items being retrieved from
search that don't exist or have a different type than those in the graph. If you see ``validate.error.incorrectType``
anywhere this is most likely the reason. Try `reindexing <../../administration/super.html#refresh-search-index>`_ 
the type that is being searched.

Links to avatar images are broken
---------------------------------

Check you're not using a ModHeader-type browser extension to set the "Authorization" header. Avatar images are stored 
on AWS which requires an "Authorization" header when requesting files. The EHRI backend also requires an "Authorization" 
header and the two can conflict if a browser extension is being used to debug either one.
