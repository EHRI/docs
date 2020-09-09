
=====================
Institution File Data
=====================

Important Note: This documentation refers to functionality in a very early stage of development and is likely to be outdated or inaccurate!
#######################################################################################################################################

Introduction
============

This documentation describes EHRI's tools for managing, transforming and ingesting XML collection descriptions. In a
nutshell, it allows administrators to:

* configure harvesting of files from OAI-PMH endpoints
* manually upload XML files
* validate XML against EHRI's EAD schema
* transform arbitrary XML to EAD using either XSLT or tabular XQuery mappings
* ingest the resulting EAD into the EHRI portal


Overview of the Data Management UI
==================================

.. image:: images/data-management-overview.png
    :alt: The data management UI

The data management UI has four tabs:

Harvesting
  For harvesting and listing files sourced from OAI-PMH endpoints. In the future, ResourceSync may also be supported.

Uploaded Files
  Where metadata files not obtained via harvesting can be uploaded, viewed and validated.

Transformation
  Where XSLT or XPath transformations can be managed, created and applied to either harvested or uploaded files.

Ingest
  Where the results of transformations can be ingested into the portal.

A note about file "stages"
^^^^^^^^^^^^^^^^^^^^^^^^^^

There are *three* types of file in the management UI:

Harvested
  Files harvested from a third-party

Uploaded
  Files uploaded manually by EHRI admins

Ingest
  Files prepared for ingest

To get files into this last stage they are transformed from either the harvest or upload stages. If no changed are
required the files will simply be copied.


Harvesting
==========

.. image:: images/data-management-harvesting.png
    :alt: The data management harvesting tab

At present the harvesting tab only supports harvesting files via the OAI-PMH protocol. To do so, click on the
"Harvest Files..." button and fill in the three fields required to describe the endpoint. These are:

OAI-PMH endpoint URL
  The address of the OAI-PMH server, without any parameters.

OAI-PMH metadata format
  The metadata format of the files to fetch, for example "ead" or "oai_dc".

OAI-PMH set
  An *optional* set specification, if required.

Clicking the "Test Endpoint" button with the parameters provided will check the endpoint exists and supports
the right data formats etc. Then, clicking the "Harvest Endpoint" button will attempt to fetch the files.

Fetched files are displayed in a table and can be previewed, validated, deleted or downloaded.


Uploading
=========

.. image:: images/data-management-upload.png
    :alt: The data management upload tab

The Uploaded Files tab shows files manually uploaded to the system and can be previewed, validated, deleted or
downloaded.

Transformation
==============

.. image:: images/data-management-transformations.png
    :alt: The data management transformation tab

The transformations tab lists the set of available transformations. A "conversion pipeline" can be configured
by dragging zero or more transformations from the available set, which will then be applied in serial, with the
output from one operation being the input to the next. If a file is selected from the preview list the preview 
window in the bottom pane will display the result of the enabled transformations or, if no transformations are active, the 
selected file unchanged.

Once a set of transformations has been enabled it can be run on the contents of either the Harvest or Upload stages by
clicking the "Convert Files..." button and selecting one or both stages as an input.

Editing transformations or creating new ones
============================================

.. image:: images/data-management-edit-transformation.png
    :alt: The data management transformation editor

Clicking the edit button on a transformation opens the transformation editor. This consists of three panes:

The top pane
  This is where the XSLT or XQuery mapping list can be edited

Bottom left pane
  This shows the input file selected from the preview list

Bottom right pane
  This shows the input file with the transformation applied

Once a transformation has been edited to your satisfaction the Save button will update it.

XSLT
....

XSLT transformations must be complete XSLT 2.0 stylesheets, and are best suited to making small changes to
documents. A minimal example that adds the EAD namespace attribute value ``urn:isbn:1=931666`` would be::

    <xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
        <xsl:output indent="yes"/>

        <xsl:template match="@*|node()">
            <xsl:copy>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:copy>
        </xsl:template>

        <xsl:template match="*" priority="1">
            <xsl:element name="{local-name()}" namespace="urn:isbn:1-931666-22-9">
                <xsl:namespace name="xlink" select="'http://www.w3.org/1999/xlink'"/>
                <xsl:apply-templates select="@*|node()"/>
            </xsl:element>
        </xsl:template>

    </xsl:stylesheet>

XQuery Mappings
...............

XQuery transformations consist of a list of mappings from the source document to the transformed output. They are best
suited to building completely new EAD documents from arbitrary input XML. Each mapping consists of four fields:

target-path
  an XPath specifying where to create a node

target-node
  the local name or, when prefixed by the ``@`` symbol, attribute name to create within the target-path

source-node
  an XPath expression pointing to a node within the source document

value
  an XPath expression giving the value of the target node, given the source node as context. For example,
  the expression ``text()`` would return the text value of the source node, whereas a quoted string such
  as ``"Some text"`` would give a literal value.

Documents should be built by adding mappings in hierarchical order.

**TIPS:**

To paste a complete set of XQuery mappings from tab-separated values, switch the editor to XSLT mode, paste
the TSV (including headers) and then switch back to XQuery mode. If the TSV was well formed things should look
as expected.

Ingest
======

.. image:: images/data-management-ingest.png
    :alt: The data management ingest tab

The ingest tab shows the files resulting from applying zero or more transformations to the harvest or upload
file stages. Here, once again, files can be previewed, validated, deleted or downloaded.

Clicking the "Ingest Files..." button will open the ingest parameters window to import data into the portal.

