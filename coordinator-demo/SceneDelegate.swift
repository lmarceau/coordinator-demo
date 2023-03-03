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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let navigationController = UINavigationController()
        // Change the coordinator you want to use for the demo here
        let coordinatorType: CoordinatorType = .basic
        switch coordinatorType {
        case .basic:
            mainCoordinator = BasicMainCoordinator(navigationController: navigationController)
            mainCoordinator?.start()
        }

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

