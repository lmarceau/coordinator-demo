//
//  RouterCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-08.
//

import UIKit

protocol Coordinatable: AnyObject, Presentable {
    var router: Router { get }
    var onCompletion: (() -> Void)? { get set }
    // Done through Coordinator protocol for now to accomodate AppDelegate to have a common type
    // func start()
}

open class RouterCoordinator: NSObject, Coordinatable, Coordinator {
    var childCoordinators: [RouterCoordinator] = []
    var router: Router

    init(router: Router) {
        self.router = router
        super.init()
    }

    open var onCompletion: (() -> Void)?
    open func start() {}

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

    // Make this function open so we can override it in a different module
    open func toPresentable() -> UIViewController {
        return router.toPresentable()
    }
}
