The Backend Model Layer
=======================

Models for the backend define the essential properties and traversal operations for different data types, and use the
Tinkerpop 2.0 Frames ORM. A crucial distinction with model classes in other frameworks is that models do not define
every property that a data type can hold, only those which are required for behaviour in the core of the stack. For
example, a ``DocumentaryUnitDescription`` item **must** have a ``languageCode`` property. Other optional properties, 
such as ``scopeAndContent`` are managed by high layers, such as the portal front-end or the data import classes.

There are several different classes of model, depending on the abstract behaviours they provide.

TODO
