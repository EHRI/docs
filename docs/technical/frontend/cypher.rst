.. _cypher:

Example Cypher usage
====================

Occasionally it's useful to use
`Cypher <http://neo4j.com/docs/1.9.9/cypher-query-lang.html>`__ to munge
the graph. Here is an example of that. The situation was as follows:

-  a group was added for annotation/link moderation (with id
   "moderators")
-  this group would be given access to private notes if their creator
   marked them *promotable*
-  however, there were existing promotable annotations already created
   that did not grant access to the moderators group (rather, they
   weren't accessible to anyone except admins)

So what we needed to do was:

-  find the moderators group
-  find all the promotable notes (with attribute ``isPromotable``)
-  check there's not already an access relation from annotation to the
   moderators group (with the label ``access`` from item to user/group)

Then finally:

-  create the access relationship on these annotations

Here's some Cypher to do the query part and check we're getting what we
expect (a few annotations):

::

    MATCH (n:Annotation {isPromotable: true}), (mods: Group {__id:"moderators"})
    WHERE NOT (n)-[:access]->(mods)
    RETURN n, n.body

Once happy that we're getting all the annotations that need fixing we
can modify our query to create the relationship:

::

    MATCH (n:Annotation {isPromotable: true}), (mods: Group {__id:"moderators"})
    WHERE NOT (n)-[:access]->(mods)
    CREATE (n)-[:access]->(mods)
    RETURN n, n.body

To briefly run through this:

::

  MATCH (n:Annotation {isPromotable: true}), (mods: Group {__id:"moderators"})`` 

Locates annotations which are promotable, and the moderators group, the latter
using its global ``__id`` property

::

  WHERE NOT (n)-[:access]->(mods)

Restricts the found nodes to those which
**don't** already have an ``access`` relationship between the note and the
moderators group

::

  CREATE n-[:access]->mods

Create the access relationship, not caring
about the result

::

  RETURN  n, n.body

Return something pretty arbitrary (the node and
its body). Had we bound the new relationship to a name in the
previous step we could have returned that instead

Example 2: Locating "orphan" documentary units
----------------------------------------------

It's a quirk of the database that documentary unit items can be
"orphaned" of someone deletes their repository or parent item, since
this does not trigger a delete cascade (for safety purposes). These
orphans can be located by finding documentary unit items with *neither*
a ``heldBy`` or a ``childOf`` relationship, like so:

::

    MATCH (d:DocumentaryUnit)
    WHERE NOT (d)-[:heldBy]-() AND NOT (d)-[:childOf]->()
    RETURN d.__id
