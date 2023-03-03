//
//  NavigationControllerDelegateChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class NavigationControllerDelegateChildCoordinator: Coordinator {

    weak var parentCoordinator: NavigationControllerDelegateMainCoordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = NavControllerDelegatePresentedViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
