=========
Use-Cases
=========

Below are some typical use-cases for administration tasks:

Allow a user to manage a repository and its data
================================================

In this case you want to allow a particular person to manage both the description of a repository and archival
descriptions which it holds. For safely, we don't want to let the user delete the repository, or inadvertently create
archival descriptions elsewhere.

The steps are as follows:

1. Get the user access to the `admin pages
   <http://documentation.ehri-project.eu/en/latest/administration/access.html#accessing-the-portal-administration-pages>`_.
2. Create a `new group <http://documentation.ehri-project.eu/en/latest/administration/groups.html#creating-groups>`_ for
   users who manage the given repository.
3. Add the user `to the new group
   <http://documentation.ehri-project.eu/en/latest/administration/groups.html#adding-users-to-groups>`_.
4. Set `item-level permissions
   <http://documentation.ehri-project.eu/en/latest/administration/groups.html#item-level-permissions>`_ on the given
   repository so that the new group can update it, **but not delete it**.
5. Set `scoped permissions
   <http://documentation.ehri-project.eu/en/latest/administration/groups.html#scoped-permissions>`_ on the repository so
   that the new group can create, update, and delete Documentary Unit items within it.

**Note:** in this case it's perfectly possible to assign the item-level and scoped permissions directly to the user
rather than to a new group that might only have one member. Creating a group is preferable however for the following
reasons:

- permissions can be revoked by simply deleting the group.
- it's clearer to other administrators that a repository is managed by specific people if there's a group for the
  purpose.
