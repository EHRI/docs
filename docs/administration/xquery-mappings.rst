*****************************************
Tabular EAD generation and transformation
*****************************************

In the `EHRI EAD dataset management interface <institution-data.html>`__ XML can be transformed using two types of transformation: XSLT documents
and tabular XQuery mappings. XSLT is more suitable for making small changes to documents, whereas XQuery transformations
can use the more expressive programmatic syntax to perform more complex tasks in a slightly easier way (your mileage
may vary though.) This documentation describes how tabular XQuery transformations are specified.


Each mapping consists of four fields:

target-path
  an XPath specifying where to create a node in the output document. This value must end with a ``/`` character.

target-node
  the local name or, when prefixed by the ``@`` symbol, attribute name to create within the target-path.

source-node
  an XPath expression pointing to a node within the source document, or ``.`` if the output node does 
  contain a value referencing the source.

value
  an XPath expression giving the value of the target node, given the source node as context. For example,
  the expression ``text()`` would return the text value of the source node, whereas a quoted string such
  as ``"Some text"`` would give a literal value. 

Documents should be built by adding mappings in hierarchical order, i.e. the ``/ead`` node should go before the
``/eadheader`` node.        


The follow provides an example that creates a minimal EAD document with fixed dummy values, and doesn't reference any
source document (you won't actually want to do this, but go with me here):

.. csv-table:: XQuery example 1
   :file: xquery-example-1.csv
   :header-rows: 1
   :class: longtable
   :widths: 1 1 1 1

That should generate output that looks like the following:

.. code-block:: xml

    <ead xmlns="urn:isbn:1-931666-22-9">
      <eadheader>
        <eadid countrycode="US">example-1</eadid>
        <filedesc>
          <titlestmt>
            <titleproper>Example EAD</titleproper>
          </titlestmt>
        </filedesc>
      </eadheader>
      <archdesc level="fonds">
        <did>
          <unitid>example-1</unitid>
          <unitdate>2021-06-01</unitdate>
          <unittitle>Example EAD</unittitle>
          <physdesc label="Extent">
            <extent>1 scrap of paper</extent>
          </physdesc>
        </did>
        <scopecontent>
          <p>Merely an example</p>
        </scopecontent>
        <accessrestrict>
          <p>None</p>
        </accessrestrict>
      </archdesc>
    </ead>

With the basic structure in place we can start adding references to the source document, which, for the sake of
simplicity, will be some Dublin Core:

.. csv-table:: XQuery example 2
   :file: xquery-example-2.csv
   :header-rows: 1
   :class: longtable
   :widths: 1 1 1 1

Now, put actual values in the third ``source-node`` column to reference the source, and an expression in the forth
column (in this case just ``text()``) to say what we want to do with the node.

Although this example is simple, these columns accept any XQuery expressions so can be as complicated as you need.
