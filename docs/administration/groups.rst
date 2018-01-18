.. _groups:

======
Groups
======

Groups in the EHRI portal admin provide a way to give users *role-based* permissions. Permissions granted to a group
will be inherited by all users who belong to it. Groups can also belong to other groups, so access to certain
functionality can be tiered.

Creating Groups
===============

Groups can only be created by EHRI super-users (those belonging to the **admin** group.) Super-users will have the
option to create new groups on the right-hand-size of the groups page:

.. image:: images/create-group-link.png
    :alt: Link to create a new group, visible to super users

The form to create a new group contains the following options:

.. image:: images/create-new-group.png
    :scale: 40%
    :alt: The new group form
    :target: _images/create-new-group.png

Identifier
  A short lowercase one-word identifier to distinguish the
  group, for example: "wp9". This must be unique within the system.

Name
  The name of the group.

Description
  A textual description of the purpose of the group.

Group Members
  If you know the users who should belong to this group
  in advance you can select them here.


Additionally, you can choose to add a message to the audit log so people know why you created this group. If you don't
have anything to add, just leave it blank.

Adding Users to Groups
======================

To add a user to a group find their account on the Users page. Then visit "Manage Groups" item from the actions menu:

.. image:: images/manage-groups-link.png
    :alt: Link to manage groups, visible to super users

Then, select the group to which you want to add them from the list.

Managing Group Permissions
==========================

**NB**: For background on the EHRI admin permission system, see the :doc:`permissions` page.

There are several classes of permission in the EHRI portal's administration system:

Global
  Allows groups (or individual users) to manage entire classes of item, e.g. archival units or repositories.

Item Level
  Allows groups (or users) to manage individual items, e.g. a single repository.

Scoped
  Allows groups to manage a class of items within a particular scope, e.g. archival units within a specific repository.

In practice these different types of permissions are often combined. A common case is a group that represents users who
are associated with a particular repository/institution. In this case the group might typically be given *item level*
permission to update the repository's description, and *scoped* permissions to create, update, or delete archival
descriptions owned by that repository.

Item Level Permissions
**********************

To set item-specific permissions for a group on a particular item, first find the item itself. Then click "Manage
Permissions" on the actions sidebar:

.. image:: images/manage-permissions-link.png
    :alt: Link to manage the individual or scoped permissions for a given item

On the next page, click the "Item Level Permissions" link:

.. image:: images/manage-permissions-item.png
    :scale: 40%
    :alt: Manage permissions for an individual item
    :target: _images/manage-permissions-item.png

Then, from the list of groups and users, select the group or user to which these item-level permissions will apply.

.. image:: images/manage-permissions-item-2.png
    :scale: 40%
    :alt: Manage permissions for an individual item
    :target: _images/manage-permissions-item-2.png

Finally, select the actual permissions, for example: `update`, to allow users belonging to the given group to update
this item:

.. image:: images/manage-permissions-item-3.png
    :scale: 40%
    :alt: Manage permissions for an individual item
    :target: _images/manage-permissions-item-3.png

You can opt to leave a log message explaining what you're doing, or just hit "Update Permissions".

Scoped Permissions
******************

The process for updating scoped permissions is the same:

1. Find the subject item
2. Click "Manage Permissions"
3. Choose "Scoped Permissions"
4. Select the group (or user) to whom the permissions apply
5. Check the individual permissions you want to grant

.. image:: images/manage-permissions-scoped.png
    :scale: 40%
    :alt: Manage scoped permissions for an item
    :target: _images/manage-permissions-scoped.png

The final screen, to select the individual permissions looks slightly different because it shows you that the
permissions in question (create, update, delete etc) apply not to the item you're currently managing, but to items of a
different type in the subject item's scope.


