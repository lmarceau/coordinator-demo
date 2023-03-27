//
//  RouterChildPushCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

// Horizontal flow
class RouterChildPushCoordinator: RouterCoordinator, ChildViewDataChanged {

    var onDataChanged: ((ChildViewData) -> Void)?

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
            child.start() { [weak self] in
                self?.removeChild(child)
                print("Router child of child Coordinator removed")
            }
            return true
        default: break
        }

        return false
    }

    func start(data: ChildViewData, onCompletion: @escaping () -> Void) {
        let presentedViewController = RouterPresentedViewController(data: data)
        presentedViewController.delegate = self
        router.push(presentedViewController, animated: true, completion: onCompletion)
    }

    // MARK: - ChildViewDataChanged
    func dataHasChanged(data: ChildViewData) {
        guard let onDataChanged = onDataChanged else { return }
        onDataChanged(data)
    }
}
