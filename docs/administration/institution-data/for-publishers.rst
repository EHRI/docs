Metadata for Data Providers
===========================

There are several ways to provide archival metadata in a manner that can be harvested and imported by the EHRI Portal.
Let's discuss separately the two parts of this problem: creating compatible metadata, and publishing it.

Metadata Formats
----------------

The EHRI Portal is based around the General International Standard Archival Description (ISAD(G)) and can import
data in the Encoded Archival Description (EAD) XML format, both 2002 and 3 variants. EAD is a very flexible schema so
aligning any particular export with our system may require some additional re-processing or re-mapping.

EAD is a hierarchical description format; a single XML file can contain the description of an entire collection,
including "units of description" at intermediate and lower levels, from series, sub-series, file, to item level, etc.
Broadly speaking, the EHRI Portal is agnostic to how many descriptive levels there are in a hierarchy, or what they are
called (this varies greatly between collection-holding institutions).

Multilinguality
~~~~~~~~~~~~~~~

Many institutions describe their archival holdings in more than one language. While the newer EAD-3 format does have some
support for multilingual finding aids, the EHRI Portal does not currently support this feature; each EAD XML file is
assumed to be in one language. The EHRI Portal *does* support multilingual descriptions, but they must be imported
separately with separate EAD XML files.

Other XML Formats
~~~~~~~~~~~~~~~~~

The EHRI Portal can perform a conversion process on EAD files in order to align them with EHRI's internal ISAD(G)-based
data model. To some extent, it can also convert arbitrary XML documents to EAD if they have a broadly compatible data
representation.

Identifiers
~~~~~~~~~~~

In order for archival descriptions to be compatible with the EHRI Portal, each "unit of description" with the collection
as a whole must have at least one **identifier**, or an ISAD(G) 3.1.1 "Reference Code". All child units within a given
archival level must have distinct identifiers. It is further recommended that identifiers are unique within the entire
institution's holdings, though this is not a hard requirement except in certain cases (see `Hierarchical Data`_ below).

Hierarchical Data
~~~~~~~~~~~~~~~~~

As noted above, EAD is a hierarchical format and a single file can contain many individual units. However, some systems
are not able to export hierarchical descriptions, and in the case of very large collections there can be technical
limitations preventing this.

In cases where individual archival units must be exported individually as single XML files, the EHRI Portal is able to
import a hierarchy as long as the parent-child relationships are provided separately as a table containing their
unique identifiers. For example, if a collection has the following structure:

.. code-block::

   * collection1
      * series1
         * file1
         * file2
      * series2
         * file3
         * file4
      * series3
         * file5

The hierarchy table would look like (noting the missing ID for the top-level collection):

.. list-table:: Hierarchy table
   :widths: 50 50
   :header-rows: 1

   * - unit ID
     - parent ID
   * - collection1
     -
   * - series1
     - collection1
   * - file1
     - series1
   * - file2
     - series1
   * - file3
     - series2
   * - file4
     - series2
   * - file5
     - series3


Other metadata formats
~~~~~~~~~~~~~~~~~~~~~~

We recognise that sometimes it is just not possible to export XML in a usable format. Therefore EHRI will do its best
to import other structured data when necessary, albeit via bespoke processes which are not considered future proof and
can cause problems in the future.

We have limited support for importing the following formats at present:

- RDF (XML flavour is best)
- Tabular (CSV is partially supported at present)

Formats like JSON and Excel are not directly supported at present, due to their complexity and/or lack of
standardised structure.

------

Now let's looks at how metadata can be published:

Publication
-----------

For the purposes of this document, the term "publication" refers to making it possible for EHRI to access archival
descriptions over the internet. This does not necessarily require making them publicly available, since methods like
IP-address whitelisting or HTTP Basic Authentication may be used to restrict access to specific harvesting clients.

EHRI supports two "standardised" protocols for harvesting, plus a more ad-hoc web-based method.

OAI-PMH
~~~~~~~

The most tried-and-tested, compatible method of metadata publication is the `Open Archives Protocol for Metadata Harvesting
(OAI-PMH) <https://www.openarchives.org/pmh/>`_. OAI-PMH is a simple XML-based web service that is compatible with a
number of existing off-the-shelf harvesting tools, and is relatively straightforward to implement by it's
`specification <https://www.openarchives.org/OAI/openarchivesprotocol.html>`_.

OAI-PMH does have some design trade-offs which can make implementation complicated, however, especially when dealing
with a more complex (hierarchical, multilingual) metadata format such as EAD, compared to something simpler like Dublin
Core.

OAI-ResourceSync
~~~~~~~~~~~~~~~~

While OAI-PMH is a protocol has a specific vocabulary of actions a client may take and wraps responses in its own
container meta-information, the `ResourceSync protocol <https://www.openarchives.org/rs/toc>`_
is much more open-ended and based around more standardised file
transfer operations. It assumes that the metadata you want to publish is accessible as a set of simple static files
(though they could be dynamically generated) and specifies a manifest format (based on the regular
`sitemap XML format <https://en.wikipedia.org/wiki/Sitemaps>`_) for enumerating and retrieving them.

EHRI only supports a subset of ResourceSync; it does not support retrieving data in ZIP or Tar format, for example.

The simplest way to implement ResourceSync is to:

* Export archival metadata as a set of XML documents
* Put them on a webserver in a publicly accessible folder
* Create a sitemap manifest linking to each file (or other manifests)

URL Sets / APIs
~~~~~~~~~~~~~~~

An advantage of the ResourceSync (or OAI-PMH) methods is that if metadata gets updated, the service or updated manifests
will allow EHRI to retrieve these updates straightforwardly. However, for even simpler cases, it is possible for EHRI to
"harvest" based on a set of URLs that point to archival descriptions. These URLs could also be endpoints that retrieve
data from an API.

Sending metadata without publication
------------------------------------

EHRI prioritises keeping data up-to-date and therefore one of the above publication methods is much preferred, since it
allows us to re-download and re-import a provider's metadata when it changes, sometimes very straightforwardly.

However, we recognise that putting material on the interest is challenging for some providers due to technical, process,
or security reasons, and therefore can accept metadata sent via other means, e.g. file sharing or email.

Summary
-------

Here are the data sharing methods in the form of a `tier list <https://en.wikipedia.org/wiki/Tier_list>`_:

S-tier:
    EAD over OAI-PMH or ResourceSync

A-tier:
    XML over OAI-PMH or ResourceSync

B-tier:
    EAD or XML via list of URLs

C-tier:
    CSV over list of URLs or ResourceSync

D-tier:
    EAD/XML over email

    Other metadata formats via list of URLs or ResourceSync

E-tier:
    Other metadata formats over email

F-tier:
    Word files, PDFs or unstructured data

