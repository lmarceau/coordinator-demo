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
#### Usage notes
- To push child coordinators for horizontal flows, we must override toPresentable() to give us a view controller instance that will work when we call router.push(coordinator) 
- To present vertical flows, the default implementation will return the router’s presentable form, which will just return the router’s underlying navigation controller. This works great to present a coordinator for a new vertical flow.
- We should create a new router when we need a new navigation controller
#### Upsides
- Clear interface to push and present
- Easy to test
- Easy to add deep links support
