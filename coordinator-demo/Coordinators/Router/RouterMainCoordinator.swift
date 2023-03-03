//
//  RouterMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class RouterMainCoordinator: Coordinator, MainCoordinator {
    var childCoordinators = [Coordinator]()

    let router: Router
    init(router: Router) {
        self.router = router
    }

    func start() {
        let viewController = MainViewController()
//        viewController.coordinator = self
//        navigationController.pushViewController(viewController, animated: false)
        router.push(viewController, animated: false, completion: {
//            childDidFinish()
        })
    }

    func button1Clicked() {
        print("Router child Coordinator added")
//        let child = RouterChildCoordinator(navigationController: navigationController)
//        childCoordinators.append(child)
//        child.parentCoordinator = self
//        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                print("Router child Coordinator removed")
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
