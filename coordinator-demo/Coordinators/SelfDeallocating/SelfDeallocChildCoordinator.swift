//
//  SelfDeallocChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-07.
//

import UIKit

class SelfDeallocChildCoordinator: Coordinator {
    weak var parentCoordinator: SelfDeallocMainCoordinator?
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        didFinish()
    }

    func start() {
        let viewController = SelfDeallocPresentedViewController()
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    func didFinish() {
        print("SelfDealloc child Coordinator removed")
    }
}
