//
//  SceneCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-09.
//

import UIKit

/// Each scene has it's own scene coordinator, which is the root coordinator for a scene.
class SceneCoordinator: Coordinator {

    let window: UIWindow?
    var mainCoordinator: Coordinator?

    // Change the coordinator you want to use for the demo here
    let coordinatorType: CoordinatorType = .router

    init(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            return
        }

        self.window = UIWindow(windowScene: windowScene)
    }

    func start() {
        let navigationController = createNavigationController()
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

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func handle(with option: DeepLinkOption) -> Bool {
        return mainCoordinator?.handle(with: option) ?? false
    }

    // MARK: - Helpers
    private func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.edgesForExtendedLayout = UIRectEdge(rawValue: 0)

        return navigationController
    }
}
