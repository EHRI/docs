Overview of the EHRI Portal and Admin front-end
===============================================

.. role:: scala(code)
    :language: scala

Frameworks and technologies
---------------------------

The portal front end is built on the `Play <http://playframework.com>`_ framework, as of this writing at version 2.6.10,
using the `Scala <http://scala-lang.org>`_ APIs. Like most Play apps it uses `SBT <https://www.scala-sbt.org>`_ as the
build tool, which also provides an interactive running and testing environment.

The primary source of data is the Neo4j-based data backend, but the app also uses a number of other data sources
including:

- a PostgreSQL database for storing various non-archival data, including user accounts
- Google Docs
- Neo4j directly, via the Cypher HTTP endpoint

General Application Structure and Modules
-----------------------------------------

The application consists of a number of modules, in a somewhat layered manner:

``backend``
  The ``backend`` module is the foundation of the app and provides the basic vocabulary for interacting with the
  backend data service.

``core``
  The ``core`` module depends on the ``backend`` module and extends it with definitions for the various models,
  additional services, authentication and authorisation, and plumbing for actions common throughout the app. Notably
  the core module uses Play's `action composition
  <https://www.playframework.com/documentation/2.6.x/ScalaActionsComposition>`_ mechanism to make the building blocks
  for common patterns of data usage, such as CRUD and access control to specific pages and resources. In almost all
  cases these components leverage the backend's access control and permission mechanisms directly.

  There are no actions (or routes) defined directly in the core module itself.

``portal``
  The portal module contains the **public** user-facing actions and routes.

``api``
  The api module depends on the portal module and contains actions for the various structured data interfaces available
  under the ``/api`` path.

``admin``
  The admin module depends on the portal module and contains provides various actions for administering portal data. Its
  routes live under the ``/admin`` path.

``guides``
  The guides module also depends on the portal module and handles the public and administrative actions available for
  viewing and managing the `EHRI research guides <http://portal.ehri-project.eu/guides>`_.

Generic Controller Interfaces
-----------------------------

See the `controllers <controllers.html>`_ page.

Model Layer
-----------

See the `models <models.html>`_ page.

Ad-hoc Data Querying via Cypher
-------------------------------

Occasionally we need to access some niche data and it's much easier just to query the database with Cypher than use the
backend web service. This is a bit unpleasant because it breaks the DB abstraction layer but ``¯\_(ツ)_/¯``.

See the `Cypher <cypher.html>`_ page for more details.

Testing
-------

We endeavour to write tests (at least integration tests) for all new features.

See the `Testing <test.html>`_ page for more details.

Issues and Technical Debt
-------------------------

Notable bits of technical debt include:

- Features relating to the Research Guides are no longer developed and essentially deprecated
- Features related to virtual collections was not finished in the scope of EHRI 1 and not funded in EHRI 2
- TODO
