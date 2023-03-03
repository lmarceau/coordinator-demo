//
//  SceneDelegate.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: Coordinator?

    // Change the coordinator you want to use for the demo here
    let coordinatorType: CoordinatorType = .router

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let navigationController = UINavigationController()
        switch coordinatorType {
        case .basic:
            mainCoordinator = BasicMainCoordinator(navigationController: navigationController)
        case .navigationControllerDelegate:
            mainCoordinator = NavigationControllerDelegateMainCoordinator(navigationController: navigationController)
        case .router:
            let router = DefaultRouter(navigationController: navigationController)
            mainCoordinator = RouterMainCoordinator(router: router)
        }
        mainCoordinator?.start()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

