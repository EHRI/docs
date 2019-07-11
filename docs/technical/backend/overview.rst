Overview of the EHRI Data Management Backend
============================================

The EHRI portal's backend is based on the `Neo4j <https://neo4j.com>`_ graph database. It is deployed as a Neo4j plugin
via the `unmanaged extensions <https://neo4j.com/docs/java-reference/current/server-extending/#server-unmanaged-extensions>`_ mechanism, which provides the means to extend Neo4j using additional `JAX-RS <https://en.wikipedia.org/wiki/Java_API_for_RESTful_Web_Services>`_ classes. 

History and Rationale
---------------------

At the beginning of the project EHRI looked around for a collections management tool that would be able to manage and
usefully integrate collections from hundreds of different institutions, with various different cataloguing styles. The
most likely candidate was ICA-AtoM (now just `AtoM <https://www.accesstomemory.org/en/>`_) which we set up to let the
project's data team gather institution and archival descriptions while the tech team considered their strategy. ICA-AtoM
filled this stopgap requirement very well but working with it (and attempting to extend it) convinced us that it would
be prohibitively difficult to adopt as a permanent platform. Notwithstanding some requirements of supposedly overriding
importance that ultimately ended up being forgotten, we needed a platform that could:

- support a relatively large number of administrative users working simultaneously on different collections, with very granular role- and content-based permissions
- manage reliable automated ingest of archival data (mainly EAD), including those with large file sizes
- keep an audit log of all significant changes to the system, allowing administrators to track who did what
- handle the integration of user-generated content in the form of notes and links between items
- be able to manage multiple simultaneous descriptions of single archival units, in different languages or from
  different sources
- be flexible and easy to adapt as we learned more about the data

After considering the options and with a dose of `NIH syndrome <https://en.wikipedia.org/wiki/Not_invented_here>`_ and the typical naivity of developers underestimating the time and energy required to create a usable system, the EHRI tech team decided to build the EHRI portal and data management backend from scratch.

Architecture
------------

Since two different workpackages were responsible for data integration and the portal interface (the former based in the
Hague and the latter in London) it was decided to make a clean distinction between the frontend and the backend,
talking to each other via a web service interface. The downside of this is that there is a fair bit of duplication in
the definitions and behaviour of backend and frontend, notwithstanding them both being JVM projects. Since the team in
the Hague mostly used Java at that time it made sense to use that language.

Neo4j was selected as the underlying database. Experience with ICA-AtoM had highlighted some of the drawbacks to a
standard SQL RMDBS system for managing archival data, most notably complications to the schema necessary to handle
genericism and hierarchical data, along with the difficulty of frequent making changes to the data model. 
Neo4j, with its index-free traversals and "schemaless" system of nodes, relationships and properties seemed a good fit for the domain and, especially, for a fluid and evolving data model. 

Over time (versions 1.8 to 3.3) Neo4j has evolved quite significantly and gained a much more powerful declarative query
language and various schema-ish features such as node labels and property constraints. This has made it much easier and
more pleasant to work with. Over the same time, however, RMDBSs like PostgreSQL have gotten much better at dealing with
semi-structured data, and, while some of the difficulties with sharing behaviour between data types and managing
object hierarchies remain, have a much deeper and more mature ecosystem of tooling. I hesitate to say we would make the same 
decision to choose Neo4j if that decision was made today, because it has definitely given us its fair share of
challenges along the way, but overall it has served us well.

When we first settled on Neo4j it was definitely considered a risk, being less mature and full-featured than more
traditional alternatives. One of the main ways of using Neo4j at that time, however, was via the `Blueprints framework
<https://github.com/tinkerpop/blueprints/>`_,
which was a sort of abstraction layer for generic graph databases. By using Blueprints it was thought we could achieve
some level of insurance against Neo4j disappearing, since it would allow us to switch (with relatively little pain) to
another graph database (such as OrientDB or Titan.) Blueprints was also just one part of a software stack called
Tinkerpop 2.0, which included many other useful tools for working with graphs, including the Gremlin traversal language
and the `Frames Object-Relational Mapper <https://github.com/tinkerpop/frames/wiki>`_.

In the intervening years the Tinkerpop stack has become an `Apache project <http://tinkerpop.apache.org/>`_ and moved
on to version 3.0, which is massively incompatible with version 2.0. EHRI remains using 2.0, which while unmaintained, is very stable and unlikely to disappear from the internet. However it is still a bit ironic that the abstraction layer we used to
ensure database independence has itself been mothballed and become probably the main tech risk in our software stack.

Neo4j Extension Endpoints
-------------------------

The Neo4j extension provides 3 endpoints under the `/ehri` path (e.g. when installed in Neo4j it is accessed via the Neo4j
server address and port, plus `/ehri`. These are:

1. The "ReSTful" interface
  A web service interface in the ReST style that can be used for general CRUD operations, along with a more RCP-like
  functions for operating on data and performing administrative functions.
2. OAI-PMH
  An `OAI-PMH 2.0 <https://www.openarchives.org/pmh/>`_ server implementation at ``/ehri/oaipmh``.
3. GraphQL
  A `GraphQL <http://graphql.org>`_ interface at ``/ehri/graphql`` for ad-hoc data exploration.

**None of these are exposed directly to the outside world**: the ReSTful interface is access via the EHRI portal HTML
interface, whereas the OAI-PMH and GraphQL endpoints are proxied by the portal more or less directly, the latter with
the addition of user authentication.

For more info about the CRUD and RCP interface, see the `API docs <http://ehri.github.io/docs/api/ehri-rest/ehri-ws/wsdocs/index.html>`_ and the `walk-through <web-service.html>`_. For more info about OAI-PMH, see the `official spec <http://www.openarchives.org/OAI/openarchivesprotocol.html>`_. For more info about GraphQL, see the `official spec <http://graphql.org>`_ and the `portal API documentation <https://portal.ehri-project.eu/api/graphql>`_. 

Project Structure
-----------------

The backend is a multi-module Maven project consisting of:

**ehri-definitions**
  Contains the "ontology" (a set of property and relationship name labels) and Entity name definitions.

**ehri-core**
  Models, access control, permissions and persistence. There is also an `Api` interface which attempts to make a
  coherent facade atop various data management operations.

**ehri-io**
  Import and export code, including EAD ingest and serialisation.

**ehri-cli**
  Command-line tools for interacting with the graph.

**ehri-ws**
  The JAX-RS classes that provide the web service interface.

**ehri-ws-graphql**
  The GraphQL implementation and a corresponding JAX-RS class for its endpoint.

**ehri-ws-oaipmh**
  The OAI-PMH 2.0 server implementation and a corresponding JAX-RS class for the endpoint.

**build**
  Maven packaging, which depends on all the other modules.

