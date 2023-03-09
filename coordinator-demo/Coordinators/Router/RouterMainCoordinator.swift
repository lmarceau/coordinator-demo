//
//  RouterMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class RouterMainCoordinator: RouterCoordinator, MainViewButtonClickDelegate {

    lazy var mainViewController = MainViewController()

    override init(router: Router) {
        super.init(router: router)
        mainViewController.coordinator = self
        router.setRootModule(mainViewController, hideBar: false)
    }

    // MARK: - MainViewButtonClickDelegate
    func button1Clicked() {
        let data = ChildViewData(data: 5)
        print("Router child Coordinator added with data \(data)")
        let coordinator = RouterChildPushCoordinator(router: router, data: data)
        coordinator.onDataChanged = { data in
            print("Router Coordinator received modified data \(data)")
        }

        // Maintain a strong reference to avoid deallocation
        addChild(coordinator)
        coordinator.start()

        // Avoid retain cycles and don't forget to remove the child when popped
        router.push(coordinator, animated: true) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            print("Router child Coordinator removed")
        }
    }

    func button2Clicked() {
        let data = ChildViewData(data: 5)
        print("Router child Coordinator added with data \(data)")
        let coordinator = RouterChildPresentCoordinator(router: router, data: data)
        coordinator.onDataChanged = { data in
            print("Router Coordinator received modified data \(data)")
        }

        addChild(coordinator)
        coordinator.start()
        router.present(coordinator, animated: true)
    }
}
