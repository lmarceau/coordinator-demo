//
//  NavigationControllerDelegateChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class NavigationControllerDelegateChildCoordinator: Coordinator, ChildViewDataChanged {

    weak var parentCoordinator: NavigationControllerDelegateMainCoordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var onDataChanged: ((ChildViewData) -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startPush(data: ChildViewData) {
        let viewController = NavControllerDelegatePresentedViewController(data: data)
        viewController.coordinator = self
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func startPresent(data: ChildViewData) {
        let viewController = NavControllerDelegatePresentedViewController(data: data)
        viewController.coordinator = self
        viewController.delegate = self
        navigationController.present(viewController, animated: true)
    }
    
    func handle(with option: DeepLinkOption) -> Bool {
        return true
    }

    // MARK: - ChildViewDataChanged
    func dataHasChanged(data: ChildViewData) {
        guard let onDataChanged = onDataChanged else { return }
        onDataChanged(data)
    }
}
