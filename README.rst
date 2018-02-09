EHRI Project Documentation
==========================

This project contains documentation for the EHRI portal administration features, plus
technical docs relating to tool development and maintenance.

Dependencies:

.. code-block:: bash

    pip install sphinx sphinx-rtd-theme

To build:

.. code-block:: bash

    cd docs
    make html

Built docs are available from ``docs/_build/html/index.html``.

If on Linux you can continuously rebuild these docs while making changes by doing something
like this from within the ``docs`` directory:

.. code-block:: bash

    while inotifywait -r --exclude _build `*`; do 
        make html
    done

On push to master a webhook is set up at readthedocs.org to make the site available at
http://documentation.ehri-project.eu.
