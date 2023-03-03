//
//  BasicChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class BasicChildCoordinator: Coordinator {

    weak var parentCoordinator: BasicMainCoordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = BasicPresentedViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
