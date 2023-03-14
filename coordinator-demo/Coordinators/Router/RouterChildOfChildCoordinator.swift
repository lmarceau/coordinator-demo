//
//  RouterChildOfChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-14.
//

import UIKit

class RouterChildOfChildCoordinator: RouterCoordinator {

    var presentedViewController: RouterChildOfChildPresentedVC

    override init(router: Router) {
        self.presentedViewController = RouterChildOfChildPresentedVC()
        super.init(router: router)
    }

    // We must override toPresentable() so it doesn't
    // default to the router's navigationController
    override func toPresentable() -> UIViewController {
        return presentedViewController
    }
}
