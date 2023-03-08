//
//  RouterMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class RouterMainCoordinator: RouterCoordinator {

    lazy var mainViewController = MainViewController()

    override init(router: Router) {
        super.init(router: router)
        mainViewController.coordinator = self
        router.setRootModule(mainViewController, hideBar: false)
    }
}

// TODO: Laurie - put MainViewButtonClickDelegate in extensions for all
extension RouterMainCoordinator: MainViewButtonClickDelegate {
    func button1Clicked() {
        print("Router child Coordinator added")

        let coordinator = RouterChildCoordinator(router: router)

        // Maintain a strong reference to avoid deallocation
        addChild(coordinator)
        coordinator.start()

        // Avoid retain cycles and don't forget to remove the child when popped
        router.push(coordinator, animated: true) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            print("Router child Coordinator removed")
        }
    }
}
