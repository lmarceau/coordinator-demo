# Coordinator project
Coordinator project demoing different implementation of solutions to common problems

## Solutions investigated
Not all solutions were investigated equally. Goal was to try different use cases with each solutions to determine which one could be used in another project. Here is the use cases tried with the solution:
- Push a view controller with coordinator
- Present a view controller with coordinator
- Presenting multiple level of child coordinators
- Deeplinks support
- Passing data between VCs

### Router
[Source 1](https://hackernoon.com/coordinators-routers-and-back-buttons-c58b021b32a), [Source 2](https://benoitpasquier.com/coordinator-pattern-navigation-back-button-swift/), [Source 3](https://www.kodeco.com/books/design-patterns-by-tutorials/v3.0/chapters/23-coordinator-pattern),  [Code 1](https://github.com/imaccallum/CoordinatorKit?ref=hackernoon.com), [Source 4](https://medium.com/hackernoon/coordinators-routers-and-back-buttons-c58b021b32a)

The router is a combination of the UINavigationControllerDelegate and NavigationController creation methods. Router is a class that wraps a UINavigationController to pass it around between coordinators. It handles the physical navigation, whereas the coordinator handles flow logic. We extend a Router class to conform to UINavigationControllerDelegate, so the router can handle all the events for the navigation controller. It wraps and delegate the responsibility for what to do on the back button event back to the coordinator that pushed this coordinator in the first place.

### Self deallocation
[Source 1](https://medium.com/codex/coordinators-the-back-button-and-how-to-solve-it-d336877a6d29), [Source 2](https://medium.com/vptech/coordinator-pattern-in-swift-without-child-coordinators-42d482d15975), [Source 3](https://stackoverflow.com/a/64664899/9516941), [Source 4](https://engineering.matchesfashion.com/how-the-coordinator-pattern-broke-my-brain-470660978a81)

Other solutions introduce a lot of boilerplate code to react to the back button being pressed. This solution makes it very simple to deallocate the child coordinator whenever it’s not needed by the view controller, the Coordinator would simply be deallocated. To achieve this, this solution is inverting the ownership of Coordinators. By allowing the view controllers to keep their Coordinator alive, when the last one view controller is removed, so is the Coordinator.

- The presenter (usually a navigation controller) is holding the view
- The view is holding the view controller
- The view controller has to have a strong reference to the view model
- The view model has to have a strong reference to the coordinator. Note that a coordinator can present one or more screens, so we can have multiple strong references of the coordinator.
To present the flows, it’s needed that the coordinator have a reference of the navigation controller or any presenter. This reference must be weak!
Once the view is pop from the view hierarchy for any reason, the view controller is released. Then, following the chain, the view model is released too and the reference of the coordinator with it.

### UINavigationControllerDelegate
[Source 1](https://khanlou.com/tag/advanced-coordinators/), [Source 2](https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios)

Involves extending the coordinator to become the navigation controller delegate, and then handling deallocation when this delegate method fires. 

### Custom back button
Considered but not implemented since we would lose the native swipe back gesture to navigate back if we go that route, so I stopped investigating it for that reason.

### Creating a NavigationController
[Source 1](https://khanlou.com/tag/advanced-coordinators/), [Source 2](https://irace.me/navigation-coordinators)

Considered but not implemented. Involves creating a Navigation Controller class that is a subclass of UIViewController with the purpose of enclosing the navigationController, conforming to UINavigationControllerDelegate, and maintaining a mapping from view controller to coordinator, so the coordinator may be deallocated upon popping the view controller.
