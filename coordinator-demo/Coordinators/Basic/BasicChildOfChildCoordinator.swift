//
//  BasicChildOfChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-10.
//

import UIKit

class BasicChildOfChildCoordinator: Coordinator {
    weak var parentCoordinator: BasicChildCoordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(with option: DeepLinkOption?) {
        guard let option = option else { return }
        switch option {
        case .childOfChild(let url):
            presentChildOfChild(url)
        default:
            break
        }
    }

    func presentChildOfChild(_ url: URL?) {
        print("Basic child of child Coordinator presented")
        let viewController = BasicChildOfChildPresentedVC(url: url)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
}
