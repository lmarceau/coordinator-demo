//
//  RouterChildPresentCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-09.
//

import UIKit

// Vertical flow
class RouterChildPresentCoordinator: RouterCoordinator, ChildViewDataChanged {

    var onDataChanged: ((ChildViewData) -> Void)?

    deinit {
        print("RouterChildPresentCoordinator deinit")
    }

    func start(data: ChildViewData, onCompletion: @escaping () -> Void) {
        let presentedViewController = RouterPresentedViewController(data: data)
        presentedViewController.delegate = self
        router.present(presentedViewController, animated: true, completion: onCompletion)
    }

    // MARK: - ChildViewDataChanged
    func dataHasChanged(data: ChildViewData) {
        guard let onDataChanged = onDataChanged else { return }
        onDataChanged(data)
    }
}
