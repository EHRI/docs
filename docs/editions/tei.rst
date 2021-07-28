***************************
TEI encoding and annotation
***************************

.. highlight:: rst

.. role:: xml(code)
   :language: xml

Documents published in the EHRI digital editions are encoded in the Text
Encoding Initiative (TEI) P5 standard. While TEI is multi-layered and
can be very complex, it is widely adopted and considered a standard
format for digital editions of texts of all kinds.

The particular TEI customisation can differ depending on the
characteristics and needs of a particular edition. While allowing for
flexibility, the EHRI editions, however, rely on the use of references
to names, dates, places and people (TEI module namesdates) as described
in TEI documentation.

TEI source information
======================

In EHRI editions, the bibliographic information about the source is
encoded in two forms in the TEI Header
(**/TEI/teiHeader/fileDesc/sourceDesc/**):

-  A display ready source information in the **<bibl>** element which
   can also include additional information about original language etc.
   This element can capture citations of non-archival sources, such as
   newspaper articles, and should always be included.
-  In addition to **<bibl>** for archival sources in a structured form
   in element **<msDesc>** which can contain **<country>**,
   **<repository>** and **<collection>**, among other structured
   information, for example:

Referencing vocabularies, main elements
=======================================

1) We use the references to keywords, places, organisations and people.

-  :xml:`<term>`: for keywords, with the attribute type “subject”. Use
   links to `EHRI
   Terms <https://portal.ehri-project.eu/vocabularies/ehri_terms>`__:

.. code-block:: xml

    <term type="subject"
          ref="https://portal.ehri-project.eu/keywords/ehri_terms-1141">passport</term>

-  :xml:`<placeName>` element for places. For camps and ghettos, the use
   of links to `EHRI
   camps <https://portal.ehri-project.eu/vocabularies/ehri_camps>`__ or
   `EHRI
   ghettos <https://portal.ehri-project.eu/vocabularies/ehri_ghettos>`__
   is preferred, with the attribute type “camp”/ “ghetto”:

He was deported to <**placeName** ref="https://portal.ehri-project.eu/keywords/ehri_camps-2" type="camp">Birkenau</\ **placeName**\ >

Linking to `Geonames records <https://www.geonames.org/>`__ is
recommended with places that aren’t included in the EHRI portal:

<**placeName** ref=\ "http://www.geonames.org/2804979/zeilsheim.html">Zeisheim
u Frankfurtu</\ **placeName**>

-  :xml:`<orgName>` for organisations. Use links to `EHRI Corporate
   Bodies <https://portal.ehri-project.eu/sets/ehri_cb>`__, for example:

<**orgName** ref="https://portal.ehri-project.eu/authorities/ehri_cb-347">JOINT</\ **orgName**>

-  :xml:`<persName>` element for people, usage of links to `EHRI
   Personalities, <https://portal.ehri-project.eu/sets/ehri_pers>`__ to
   `Yad Vashem’s Central Database of Shoah Victims’ Names
   database <https://yvng.yadvashem.org/>`__, or similar authoritative
   resources is recommended:

<**persName** ref="https://portal.ehri-project.eu/authorities/ehri_pers-000272">Mengele</**persName**>

<**persName** ref="*http://yvng.yadvashem.org/nameDetails.html?itemId=4763965*">Felixem Stiastny-m\ **</persName**>

Mark also people (or other types of entities) that have no corresponding
record in the EHRI portal or in other usual repositories, for example:

SS officer <**persName**>Nowak</\ **persName**>

Attribute @ref: use URL of the linked record as a unique identifier. If
you copy URLs from the EHRI Portal, please don’t copy the language
parameter at the end of the URL (for instance “#desc-eng”).

2) Text formatting

-  **<hi** rend=\ **"bold"**>Bold text</\ **hi**>
-  **<hi** rend=\ **"italic"**>Italic text</\ **hi**>
-  **<hi** rend=\ **"underlined"**>Underlined text</\ **hi**>

3) Dates

-  **<date**\  when=\ **"1940-02-11"**>11th February 1940</\ **date**>
-  **<date**\  when=\ **"1940-02"**>early February 1940</\ **date**>

4) Quotations

-  We use element **<q>**\ to mark quotations (replace quotation marks
   with element tags), for example:

[...] came to pick him up with the words **<q>**\ Another one's
croaked.\ **</q>**

5) Notes, remarks

-  We use element <**note**> with the attribute type
   “translation”/”gloss” for remarks:

**<note** type=\ **"translation"**>special treatment</\ **note**>

**<note** type=\ **"gloss"**>The real date of the event must have been
May 1942.</\ **note**>

6) Page breaks

-  Element <pb> is used, with the attribute type “facs” when we want to
   relate to images of individual pages outside of the document, for
   example:

<**pb** n="1" facs="EHRI-ET-YV3549264_01.jpg"/>

7) Other languages, camp language/slang

-  Use element <**foreign**> with the “xml:lang” attribute type to mark
   the words or phrases in other languages, for example:

<**foreign** xml:lang="de">Sonderbehandlung</\ **foreign**>

-  Analogically, use element <**distinct**> for camp language or slang:

I went to the <**distinct**
type=”camp_language”>Schleusse</\ **distinct**>.

8) Typos

-  For historical editions, methodologies often recommend correcting
   mistakes such as typos which have no bearing on the understanding of
   the context or meaning of the document (such an approach can be
   explained in the introduction of a particular edition). If we decide
   to record the individual mistake or in cases where the correction
   carries meaning, we can use the **<sic>** element, or - with
   correction - in this form:

.. code-block:: xml

    <choice>
        <sic>deprtation</sic>
        <corr>deportation</corr>
    </choice>

TEI enhancement utility
=======================

A command-line utility written in PHP (for the purpose of the possible
integration into Omeka) was developed to support enrichment of the
linked controlled vocabularies. It traverses across the entities linked
in the body of TEI files and performs rule-based enrichment of the TEI
headers by fetching metadata using the EHRI and Geonames resources.

The utility adds normalised records in the TEI header, in conformance
with the Dublin Core - TEI mapping listed above. Currently, it uses the
EHRI API to process the following EHRI vocabularies: places, camps,
ghettos and terms. Based on the Geonames RDF service, it creates place
records containing geographic coordinates and links to further resources
(such as Wikipedia articles). An argument can be specified to prefer
data in a specific language (if available). The utility can be extended
to include other services with machine readable information.

Documentation of command line options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TODO