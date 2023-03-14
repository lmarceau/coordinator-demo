//
//  SelfDeallocChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-07.
//

import UIKit

class SelfDeallocChildCoordinator: Coordinator, ChildViewDataChanged {
    weak var parentCoordinator: SelfDeallocMainCoordinator?
    weak var navigationController: UINavigationController?

    var onDataChanged: ((ChildViewData) -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        didFinish()
    }

    func startWithPush(data: ChildViewData) {
        let viewController = SelfDeallocPresentedViewController(data: data)
        viewController.coordinator = self
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    func startWithPresent(data: ChildViewData) {
        let viewController = SelfDeallocPresentedViewController(data: data)
        viewController.coordinator = self
        viewController.delegate = self
        navigationController?.present(viewController, animated: true)
    }

    func handle(with option: DeepLinkOption) -> Bool {
        return true
    }

    func didFinish() {
        print("SelfDealloc child Coordinator removed")
    }

    // MARK: - ChildViewDataChanged
    func dataHasChanged(data: ChildViewData) {
        guard let onDataChanged = onDataChanged else { return }
        onDataChanged(data)
    }
}
