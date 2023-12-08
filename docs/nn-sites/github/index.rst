Setting up a new NN page on Github
==================================

While it is strongly recommended to use Git to manage the content of your NN page, it is
possible to edit the content directly on Github. This tutorial will explain how
to set up a new NN page without leaving Github, and a brief overview of how to
manage content.

#. **Create a Github account if you don't have one already:**

    https://github.com/join
    
   |br|

#. **Visit the repository on Github:**

    https://github.com/EHRI/ehri-nn-hugo-template
    
   |br|

#. **Go to "Fork" near the title and select "Create a new fork"**

   Select yourself as the "Owner" and put something like "ehri-gb-test" as the repository name.

   Provide an optional description if you wish.

   Locate your new "Fork" at https://github.com/<YOUR_USERNAME>/<YOUR_REPOSITORY_NAME>

   |br|

#. **Go to "Settings":**

   .. figure:: images/new-repo-go-to-settings.png
      :alt: Go to Settings

   |br|

#. **On the left hand side, select "Pages":**

   .. figure:: images/in-settings-select-pages.png
      :alt: Select Pages
      :align: center

   |br|

#. **Under "Build and Deployment" select "Github Actions":**

   .. figure:: images/under-build-and-deployment-select-github-actions.png
      :alt: Select Github Actions

   |br|

#. **Now, on the top of the page, select "Actions"**

   |br|

#. **On the left, click "Deploy Hugo site to Pages"**

   |br|

#. **On the action, select "Run workflow"**

   .. figure:: images/under-actions-select-workflow-and-run.png
       :alt: Select Workflow and Run
       :align: center

   |br|

   It should say "Queued" whilst running. After
   a few minutes, it should say "Success" and you should be able to visit your new
   at https://<YOUR_USERNAME>.github.io/<YOUR_REPOSITORY_NAME>

   .. figure:: images/workflow-will-say-queued-whilst-running.png
       :alt: Select Workflow and Run
       :align: center

   |br|

   |br|

Customising your new NN page
----------------------------

Visit the repository where you forked the NN template on Github, at
https://github.com/<YOUR_USERNAME>/<YOUR_REPOSITORY_NAME>

Let's just explain a few files and what they do:

* ``config.yaml``: This is the main configuration file for your NN page. It contains
  the title, description, and other settings. You can edit this
  file directly on Github by clicking on it and then clicking the pencil icon
  on the top right. When you are done, click "Commit changes" at the bottom of
  the page, which will trigger the deployment workflow and update the HTML site.

* ``content/``: This folder contains the content of your NN page. The content is
  typically written in Markdown, which is a simple text format that is easier to
  write than HTML. Files directly within the ``content/`` folder will be top-level
  pages on your NN site. For example, ``content/about.md`` will be the "About" page.
  For news items, you can create Markdown files in the ``content/news/`` folder.

* ``static/``: This folder contains static files for the overall site that are not
  part of the content, for example, logo images for funders/partners etc.

* ``themes/``: This folder contains the NN theme. You should not need to edit this
  folder directly.

* ``layouts/``: This folder contains the HTML templates for the NN site. You should
  only need to add new templates if you want to add new types of pages to the site.

* ``data/``: This folder contains data files in YAML format that define certain parts
  of the site, for example, the list of partners or the people in the "People" page.

* ``archetypes/``: This folder contains templates for new pages.

* ``i18n/``: This folder contains translations of various texts used in the site,
  outside of the content, for example, the menus, header, and footer.

Adding a new News Item
~~~~~~~~~~~~~~~~~~~~~~

#. **Navigate to the "content/news/" folder and click "Add File", then "Create new file"**

   |br|

#. **Create a new directory called ``my-news-item`` followed by a slash**

   Github's web UI will automatically create a new directory when you type a slash
   at the end of the name and press enter.

   |br|

#. **Create a new file called ``index.md`` by typing that in the filename box**

   |br|

#. **Add the following content to the file:**

    .. code-block:: markdown

        ---
        title: My News Item
        date: 2023-12-11
        ---

        This is my news item, about a thing that has happened, or will happen.

   Some things to watch out for here:

    * The ``title`` is the title of the news item.
    * The ``date`` is the date of the news item. It should be in the format ``YYYY-MM-DD``. The
      date is used to sort the news items, so the most recent news items will appear first.
      **If the date is in the future, the page will not be created.**

    |br|

    .. note::
       You can find info about other available fields in the Hugo documentation:

         https://gohugo.io/content-management/front-matter/#front-matter-variables

    |br|

#. **Click "Commit changes"**

    |br|

#. **Add a commit message like "Add my news item" and click "Commit changes" at the bottom**

    |br|

#. **Wait a few minutes for the site to be updated**

   If you go back to the "Actions" tab, you should see a new action running with
   your commit message. After a few seconds or minutes it should turn green.

    |br|

#. **Visit your NN site and go to /news/**

    |br|

#. **Add a featured image to your news item**

   You can add a featured image to your news item by adding an image file
   in the same ``content/news/my-news-item`` directory as the ``index.md`` file, called, for example,
   ``featured-image.jpg``. Then, in the ``index.md`` file, add the following
   line to the front matter:

    .. code-block:: markdown

        ---
        title: My News Item
        date: 2023-12-11
        image: featured-image.jpg
        ---

        This is my news item, about a thing that has happened, or will happen.

   |br|



.. # define a hard line break for HTML
.. |br| raw:: html

   <br />