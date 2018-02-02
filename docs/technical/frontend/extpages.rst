.. _extpages:

External HTML Pages
===================

An external HTML page is one where the content is managed in Google Docs rather than the portal directly. You can think of this like a very crude CMS and it is used by the `FAQs page <https://portal.ehri-project.eu/help/faq>`_ and other help pages. To set up external pages you need to add a route to the portal of the form:

::

    GET    /mypage   @controllers.portal.Portal.externalPage("mypage")

where `mypage` has a corresponding config value of the form:

::

    pages {
        external {
            google {
                mypage {
                    default: "http://url.to.my.page/"
                    en: "http://url.to.my.page/en/"
                    fr: "http://url.to.my.page/fr/"
                }
            }
        }
    }

Here, the ``default`` key is the canonical URL, with keys corresponding to language codes providing language-specific
alternatives. If a language is used which is not define the default page will be used.

In addition to the URL config, it is also necessary to define I18N messages for the page name and description, e.g.:

::

    pages.external.mypage.title=My Page Name
    pages.external.mypage.description=Useful info

