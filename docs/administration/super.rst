.. _super:

Superuser Administration Tools
==============================

Superusers will have a number of extra database administration tools available to them in the 'More...' section of the
EHRI admin menu. **BEWARE**: these are often dangerous if not used with due consideration!

Database Queries
----------------

Database queries are `Cypher queries <../technical/frontend/cypher.html>`_ that can be saved in order to produce a
particular type of tabular data on demand, with the results available as JSON, TSV, or CSV.

.. image:: images/cypher-queries.png
    :scale: 40%
    :alt: Database Queries
    :target: ../_images/cypher-queries.png

Viewing the query as HTML will show you the results and allow you to download them in other formats.


Refresh Search Index
--------------------

While most of the time the frontend app keeps the search index in sync with the database, it's sometimes necessary to do
this manually. Especially when, for example, you tinker with the database outside of the app, which does happen from
time to time. At the time of writing, rebuilding the search index from a clean slate takes about 10-15 minutes, but
refreshing individual data types (e.g. repositories or links) is much quicker. The "Refresh Search Index" page provides
an interface that allows you to rebuild specific data types, or the whole index if necessary.

There are a few options on this page:

Clear Entire Index First
  This will delete everything from the search index. Don't check this unless you really was to rebuild from scratch

Clear Each Type First
  This will delete all items of corresponding data types from the index. This is useful if you think there is leftover
  data or orphaned items and can often be good practice to keep things clean. Beware though, if you check this people
  will not be able to search for items of that type while they are reindexing (i.e. the delete and reindex operations
  are not transactional.)

Types to Update
  A list of data types to reindex, check those that apply.

Find and Replace
----------------

Find and Replace allows you to replace known property values for a specific item type with some other value. **This is a
potentially dangerous tool and should be used with care.** You also need to know something about the database schema to
use it effectively, but it is useful doing behind-the-scenes corrections on a lot of items, for example, fixing broken
URL references. 

.. image:: images/find-replace.png
    :scale: 40%
    :alt: Find and Replace
    :target: ../_images/find-replace.png



The form has a number of options:

Item type
  Select the database name of the *content type* you want to alter

Sub-type
  Select the component (or subordinate) type of the database node to operate on, or the content type if they are the
  same

Property
  Type the name of the subtype's property to search

Text to find
  The text to match

Replacement text
  The replacement text

Log message
  Explain (for the audit log) why this change took place

Once you click the "Find" button the database will be searched for matching candidates. This may take some time if
you're searching a populous item type (reason: it does a full iteration rather than an index lookup.) Items matching the
text to find will be listed below. Check this looks how you'd expect. Then click the "Replace [num-found] values" button
to commit the change.

Note: you can only change up to 100 values at a time.

Regenerate Item IDs
-------------------

TODO

Rename Local Identifiers
------------------------

TODO

Reparent Items
--------------

TODO

Batch Delete Items
------------------

TODO
