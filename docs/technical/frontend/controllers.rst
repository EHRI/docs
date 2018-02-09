Controllers and Action Composition
==================================

There are quite a number of entity types in use in the EHRI portal and most of their behaviours with regard to
permissions, access control, and the `CRUD lifecycle <https://en.wikipedia.org/wiki/Create,_read,_update_and_delete>`_
are shared. To greatly reduce code duplication the portal app makes extensive use of Play's Action Composition
mechanism, dividing up these generic behaviours into a set of parameterised traits that can be mixed into controllers to
handle operations on a particular type of entity. In addition to just Create, Read, Update, and Delete, we also have
generic controller traits for:

- Setting item-level permissions
- Setting scoped permissions
- Setting visibility (access control)
- Promotion
- Search
- Creating child items
- Managing descriptions

The `UserProfile` and `Group` types also share quite a bit of behaviour since they can both be added to other groups and
be assigned global permissions to manage entire item types; these are also implemented via generic controller traits.

In general, generic actions consist of two parts:

1. rendering a form
2. validating the form data, and either:
   - re-rendering the form with errors
   - acting on the form data

In general we don't do any actual rendering since the specific data rendered will depend on the item type; this part is
left to the concrete controller implementation.

In both cases we also need to validate that the user performing the action has permission to do it. This happens a
lot, so most of the generic controllers themselves compose an ActionBuilder called
:scala:`WithContentPermissionAction(permissionType, contentType)` that either allows to action to proceed or renders a
403 Forbidden response.

Simplified Example
------------------

A simplified example of this system is shown below; it handles one particular action (setting item visibility) for the
``Country`` data type:

.. code-block:: scala

  case class Countries @Inject()(
    controllerComponents: ControllerComponents,
    appComponents: AppComponents
  ) extends AdminController with Visibility[Country] {

    def get(id: String: Action[AnyContent] = ??? // Stubbed for this example...


    def visibility(id: String): Action[AnyContent] = EditVisibilityAction(id).apply { implicit request =>
      Ok(views.html.admin.permissions.visibility(request.item,
        forms.VisibilityForm.form.fill(request.item.accessors.map(_.id)),
        request.users, request.groups, countryRoutes.visibilityPost(id)))
    }
  
    def visibilityPost(id: String): Action[AnyContent] = UpdateVisibilityAction(id).apply { implicit request =>
      Redirect(controllers.countries.routes.Countries.get(id))
        .flashing("success" -> "item.update.confirmation")
    }
  }
    
This (simplified) controller mixes in the ``Visibility[T]`` trait, parameterised by the ``Country`` model. The trait
provides two composable actions: ``EditVisibilityAction`` and ``UpdateVisibilityAction``:

``EditVisibilityAction``
  This checks for the user's permission to update the item's visibility and, if they are allowed, runs a function taking a
  ``VisibilityRequest`` (which contains the item in question and other contextual info such as a list of possible 
  users and groups to grant access) and returning a response. In our example controller this renders a form with a 200
  response, pre-filling the form with the IDs of the users and groups who can currently access the item.

``UpdateVisibilityAction``
  This also checks for the user's permission to update the item's visibility and, if allowed, sets it from the form data
  and runs an action taking another request and returning a response. In our example this simply redirects to the item's
  detail page.
  
Most of the generic controller have similar New/Create, Edit/Update pairs which map to a
``doThing``/``doThingPost`` actions. Some are more complicated in that they return a request which contains *either* a
form of some type (if the form was invalid) *or* a new or updated item. For example, the ``CreateItemAction`` action
builder users a ``CreateRequest[A]``, which is a wrapped request which, simplified slightly, looks like:

.. code-block:: scala

  case class CreateRequest[A](
    formOrItem: Either[Form[F],MT],
    user: UserProfile,
    request: Request[A]
  ) extends WrappedRequest[A](request)

That is, the caller receives a request containing either a ``Form[F]`` (where ``F`` is the type of the item's data) or an item of type ``MT`` so they can either render the form again or do something with the newly-created item.





