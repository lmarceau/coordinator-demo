//
//  RouterChildOfChildCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-14.
//

import UIKit

class RouterChildOfChildCoordinator: RouterCoordinator {

    override init(router: Router) {
        super.init(router: router)
    }

    deinit {
        print("RouterChildOfChildCoordinator deinit")
    }

    func start(onCompletion: @escaping () -> Void) {
        let presentedViewController = RouterChildOfChildPresentedVC()
        router.present(presentedViewController, animated: true, completion: onCompletion)
    }
}
