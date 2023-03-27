//
//  RouterCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-08.
//

import UIKit

// This will be called Coordinator in another project so we have only one protocol. This currently exists only since
// we support many coordinator type in this particular project.
protocol Coordinatable: AnyObject {
    var router: Router { get }
}

open class RouterCoordinator: NSObject, Coordinatable {
    var childCoordinators: [RouterCoordinator] = []
    var router: Router

    init(router: Router) {
        self.router = router
        super.init()
    }

    // No start function since parameters will be passed in each coordinator custom start method.
    // This means having a default one without parameter isn't useful
//    open func start() {}

    // Loop through existing child coordinators to see if we handle deeplink
    func handle(with option: DeepLinkOption) -> Bool {
        for child in childCoordinators {
            let isHandled = child.handle(with: option)
            if isHandled {
                return isHandled
            }
        }
        return false
    }

    func addChild(_ coordinator: RouterCoordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: RouterCoordinator?) {
        guard let coordinator = coordinator,
              let index = childCoordinators.firstIndex(of: coordinator)
        else { return }

        childCoordinators.remove(at: index)
    }
}
