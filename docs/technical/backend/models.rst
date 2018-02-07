The Backend Model Layer
=======================

Models for the backend define the essential properties and traversal operations for different data types, and use the
Tinkerpop 2.0 Frames ORM. A crucial distinction with model classes in other frameworks is that models do not define
every property that a data type can hold, only those which are required for behaviour in the core of the stack. For
example, a ``DocumentaryUnitDescription`` item **must** have a ``languageCode`` property. Other optional properties, 
such as ``scopeAndContent`` are managed by high layers, such as the portal front-end or the data import classes.

Abstract Model Types
--------------------

Because Tinkerpop Frames models are Java interfaces (with instances created by proxies at runtime) they can themselves
extend multiple other interfaces. For better or worse, we use this extensively as a form of multiple inheritance so 
that "concrete" model instances can inherit behaviours (graph traversals and property accessors) from abstract base models. 
For example, there is a base model called ``Identifiable`` that looks like this:

.. code-block:: java

  package eu.ehri.project.models.base;
  
  import com.tinkerpop.frames.Property;
  import eu.ehri.project.definitions.Ontology;
  import eu.ehri.project.models.annotations.Mandatory;
  
  /**
   * Base interface for entities that have an identifier property (other than the
   * internally assigned node ID).
   */
  public interface Identifiable extends Entity {
  
      @Mandatory
      @Property(Ontology.IDENTIFIER_KEY)
      String getIdentifier();
  }


Models that inherit from ``Identifiable`` then get a ``getIdentifier()`` method which looks up the property via the
``identifier`` key. Because this property accessor is marked @Mandatory a model instance cannot be stored if the
property is missing or empty.

Other abstract base model interfaces exhibit more complex behaviours. For example, the ``Accessible`` interface defines
behaviour for any entity that:

- requires access control and permissions
- has a lifecycle stored in the audit log

These behaviours mean that any ``Accessible`` item can have certain relationships to other nodes, such as an ``access``
relationship to any node that inherits the ``Accessor`` behaviour (both ``UserProfile`` and ``Group`` models.)

Similarly, any model that inherits the ``PermissionScope`` interface is one that can contain other items to which
permissions can be granted. For example, the ``Repository`` model is a ``PermissionScope`` because it contains
``DocumentaryUnit`` items, and users or groups can be granted permission to create ``DocumentaryUnit`` items within the
scope of that repository.

Here are some of the most important abstract models:

``Entity``
  All models inherit from ``Entity``. It defines accessors called ``getId()`` and ``getType()`` which read,
  respectively, the ``__id`` and ``__type`` properties which are present on all model nodes in the graph.

``Accessible``
  Models that can have their access restricted by the presence of a ``access`` relationship to one or more ``Accessor``
  nodes. Also defines behaviour for reading history by retrieving a set of ``Version`` nodes.

``Described``
  Models that can be related to ``Description`` nodes via an incoming ``describes`` relationship.

``PermissionScope``
  Models that can be the containing scope for permissions pertaining to other items.

``Annotatable``
  Models that can have an incoming ``annotates`` relationship from an ``Annotation`` node.

Concrete model types
--------------------

Concrete model types can be actually saved in the graph. Their name corresponds to their ``__type`` property (and also
their Neo4j node label - this redundancy is due to node labels being added to Neo4j after we were using the ``__type``
property.)

**AccessPoint**
  A node representing an access point, which is EHRI lingo for a reference to another item, e.g. a ``<subject>>`` tag in
  an EAD file. The access point just contains text, not an actual link, but it can also be the body of a ``Link`` node.

**Address**
  A node representing an address.

**Annotation**
  A node representing an annotation, which can point to any ``Annotatable`` item.

**ContentType**
  A node which represents data types to which permissions can attached. The ``__id`` property corresponds to the name of
  the data type, e.g. ``Country`` or ``DocumentaryUnit``.

**Country**
  A node representing a county. The ``__id`` is the lowercase ISO 3166-2 code.

**DatePeriod**
  A node representing a span of time, with ``startDate`` and ``endDate`` properties.

**DocumentaryUnit**
  A node representing an archival unit, which is either ``heldBy`` a ``Repository`` or the ``childOf`` another 
  ``DocumentaryUnit`` item.

**DocumentaryUnitDescription**
  A description of an archival unit, with properties corresponding to ISAD(G).

**Group**
  A group, to which ``UserProfile`` or other ``Group`` nodes can belong, via the ``belongsTo`` property.

**HistoricalAgent**
  A node representing a person, corporate body, or family.

**HistoricalAgentDescription**
  A description of a historical agent, with properties corresponding to ISAAR.

**Link**
  A node representing a link between two items, via the ``hasLinkTarget`` property. A link can also have an
  ``AccessPoint`` body, which provides its name.

**MaintenanceEvent**
  A node representing a change to an item which occured prior to its ingest.

**Permission**
  A node representing a type of permission, with its ID as the permission identifier, e.g. ``create`` or ``update``.

**PermissionGrant**
  A node representing a grant of some given ``Permission`` to a particular target, where the target could be either a
  specific ``Accessible`` item, or a ``ContentType`` node. A ``PermissionGrant`` can also have a particular
  ``PermissionScope``.

**Repository**
  A node representing an archival institution.

**RepositoryDescription**
  A description of an archival institution, with properties corresponding to ISDIAH.

**UnknownProperty**
  A node repesenting some ingest data we do not recognise, but someone might want to look at.

**UserProfile**
  A node representing a user of the system, potentially belonging to one or more ``Group`` nodes.

**VirtualUnit**
  A node representing a "virtual" archival entity, which does not exist in any actual archive, but serves the purpose of
  allowing non-virtual material to be collected together in virtual space.


