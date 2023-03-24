//
//  RouterChildPushCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

// Horizontal flow
class RouterChildPushCoordinator: RouterCoordinator, ChildViewDataChanged {

    var presentedViewController: RouterPresentedViewController
    var onDataChanged: ((ChildViewData) -> Void)?

    init(router: Router, data: ChildViewData) {
        self.presentedViewController = RouterPresentedViewController(data: data)
        super.init(router: router)

        presentedViewController.delegate = self
    }

    deinit {
        print("RouterChildPushCoordinator deinit")
    }

    override func handle(with option: DeepLinkOption) -> Bool {
        let isHandled = super.handle(with: option)
        guard !isHandled else { return isHandled }

        // If not existing, check if we should support the deeplink
        // return false if not handled, or true if handled
        switch option {
        case .childOfChild:
            let child = RouterChildOfChildCoordinator(router: router)
            print("Adding child of child coordinator")
            addChild(child)
            router.push(child, animated: true, completion: {
                print("Removing child of child coordinator")
                self.removeChild(child)
            })
            return true
        default: break
        }

        return false
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
