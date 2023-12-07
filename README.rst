EHRI Project Documentation
==========================

This project contains documentation for the EHRI portal administration features, plus
technical docs relating to tool development and maintenance.

To update these docs you can either:

* make changes directly on Github (ask for the repo rights first)
* or, for more significant changes, checkout the code and build the site locally,
  then create a pull request

To do this you need to install the Python dependencies:

.. code-block:: bash

    pip install sphinx sphinx-rtd-theme

To then generate the HTML like so:

.. code-block:: bash

    cd docs
    make html

Then you can open this page in your browser: ``docs/_build/html/index.html``.

If using Linux you can continuously rebuild these docs while making changes by doing something
like this from within the ``docs`` directory:

.. code-block:: bash

    while inotifywait -r --exclude _build *; do 
        make html
    done

On MacOS, install the ``fswatch`` command and use something like this:

.. code-block:: bash

    fswatch -r --exclude _build . | (while read; do make html; done)

On push to the master branch a webhook is set up at readthedocs.org to make the site available at
http://documentation.ehri-project.eu.

If you see any problems, inaccuracies, or things that need updating feel free to open an issue on Github.
