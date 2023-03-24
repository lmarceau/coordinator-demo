//
//  RouterChildPresentCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-09.
//

import UIKit

// Vertical flow
class RouterChildPresentCoordinator: RouterCoordinator, ChildViewDataChanged {

    var presentedViewController: RouterPresentedViewController
    var onDataChanged: ((ChildViewData) -> Void)?

    init(router: Router, data: ChildViewData) {
        self.presentedViewController = RouterPresentedViewController(data: data)
        super.init(router: router)

//        router.setRootModule(presentedViewController, hideBar: false)
        presentedViewController.delegate = self
    }

    deinit {
        print("RouterChildPresentCoordinator deinit")
    }

    // MARK: - ChildViewDataChanged
    func dataHasChanged(data: ChildViewData) {
        guard let onDataChanged = onDataChanged else { return }
        onDataChanged(data)
    }

    override func toPresentable() -> UIViewController {
        return presentedViewController
    }
}
