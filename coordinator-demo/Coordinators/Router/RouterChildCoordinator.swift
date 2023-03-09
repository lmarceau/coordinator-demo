//
//  RouterChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class RouterChildCoordinator: RouterCoordinator, ChildViewDataChanged {

    var presentedViewController: RouterPresentedViewController
    var onDataChanged: ((ChildViewData) -> Void)?

    init(router: Router, data: ChildViewData) {
        self.presentedViewController = RouterPresentedViewController(data: data)
        super.init(router: router)

        presentedViewController.delegate = self
    }
    
    // We must override toPresentable() so it doesn't
    // default to the router's navigationController
    override func toPresentable() -> UIViewController {
        return presentedViewController
    }

    // MARK: - ChildViewDataChanged
    func dataHasChanged(data: ChildViewData) {
        guard let onDataChanged = onDataChanged else { return }
        onDataChanged(data)
    }
}
