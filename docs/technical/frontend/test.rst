Notes on testing
================

Running most portal frontend tests (specifically, integration tests) 
requires there to be a backend running on port 7575. The easiest way
to do this is via Docker:

::

    sudo docker run --publish 7575:7474 -it ehri/ehri-rest

Then it should be then possible to just run ``sbt test``.

Running a single test
---------------------

Tests are written using the `Specs2`_ framework. A single test is called an
example, e.g:

.. code:: scala

    package mytests

    class SomeSpec extends Specification {
        "something" should {
            "do something" in {
                // some text code
                ...
            }
        }
    }

To run just the "do something" example here, it's best to load the Play
shell with ``sbt`` (assuming sbt is installed) and run:

::

    sbt> testOnly mytests.SomeSpec -- ex "do something"


.. _Specs2: https://etorreborre.github.io/specs2/    
