//
//  SelfDeallocMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class SelfDeallocMainCoordinator: Coordinator {
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: false)
    }
}

extension SelfDeallocMainCoordinator: MainViewButtonClickDelegate {
    func button1Clicked() {
        print("SelfDealloc child Coordinator added")
        let child = SelfDeallocChildCoordinator(navigationController: navigationController!)
        child.start()
    }
}
