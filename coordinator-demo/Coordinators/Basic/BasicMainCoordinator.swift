//
//  BasicMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class BasicMainCoordinator: Coordinator, MainCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }

    func button1Clicked() {
        print("BasicChildCoordinator added")
        let child = BasicChildCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                print("BasicChildCoordinator removed")
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}