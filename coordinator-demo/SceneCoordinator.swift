//
//  SceneCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-09.
//

import UIKit

class SceneCoordinator: Coordinator {

    let window: UIWindow
    var mainCoordinator: Coordinator?

    // Change the coordinator you want to use for the demo here
    let coordinatorType: CoordinatorType = .selfDealloc

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigationController = UINavigationController()
        switch coordinatorType {
        case .basic:
            mainCoordinator = BasicMainCoordinator(navigationController: navigationController)
        case .navigationControllerDelegate:
            mainCoordinator = NavigationControllerDelegateMainCoordinator(navigationController: navigationController)
        case .router:
            let router = DefaultRouter(navigationController: navigationController)
            mainCoordinator = RouterMainCoordinator(router: router)
        case .selfDealloc:
            mainCoordinator = SelfDeallocMainCoordinator(navigationController: navigationController)
        }
        mainCoordinator?.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
