//
//  BasicChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class BasicChildCoordinator: Coordinator, ChildViewDataChanged {
    weak var parentCoordinator: BasicMainCoordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var onDataChanged: ((ChildViewData) -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startPush(viewData: ChildViewData) {
        let viewController = BasicPresentedViewController(data: viewData)
        viewController.coordinator = self
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func startPresent(viewData: ChildViewData) {
        let viewController = BasicPresentedViewController(data: viewData)
        viewController.coordinator = self
        viewController.delegate = self
        navigationController.present(viewController, animated: true)
    }

    func handle(with option: DeepLinkOption) -> Bool {
        // Loop through existing child coordinators to see if we handle deeplink
        // This can be in a default implementation of protocol
        for child in childCoordinators {
            let isHandled = child.handle(with: option)
            if isHandled {
                return isHandled
            }
        }

        // If not existing, check if we should support the deeplink
        // return false if not handled, or true if handled
        switch option {
        case .childOfChild:
            let child = BasicChildOfChildCoordinator(navigationController: navigationController)
            child.parentCoordinator = self
            childCoordinators.append(child)
            return child.handle(with: option)
        default: break
        }

        return true
    }

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                print("Basic child of child Coordinator removed")
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    // MARK: - ChildViewDataChanged
    func dataHasChanged(data: ChildViewData) {
        guard let onDataChanged = onDataChanged else { return }
        onDataChanged(data)
    }
}
