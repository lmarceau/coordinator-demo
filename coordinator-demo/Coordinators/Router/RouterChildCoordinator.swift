//
//  RouterChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

// Laurie: This is a horizontal flow
class RouterChildCoordinator: RouterCoordinator {

    let presentedViewController = RouterPresentedViewController()

    // We must override toPresentable() so it doesn't
    // default to the router's navigationController
    override func toPresentable() -> UIViewController {
        return presentedViewController
    }
}
