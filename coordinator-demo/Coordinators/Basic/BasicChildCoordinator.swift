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
