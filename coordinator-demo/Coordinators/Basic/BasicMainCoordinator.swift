//
//  BasicMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class BasicMainCoordinator: Coordinator, MainViewButtonClickDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }

    func handle(with option: DeepLinkOption) -> Bool {
        // Loop through existing child coordinators to see if we handle deeplink
        // This can be in a default implementation of protocol
        for child in childCoordinators {
            let isHandled = child.handle(with: option)
            if isHandled {
                return isHandled
            }
        }

        // If not existing, check if we should support the deeplink
        // return false if not handled, or true if handled
        switch option {
        case .child: pushChild()
        case .childOfChild:
            let child = BasicChildCoordinator(navigationController: navigationController)
            childCoordinators.append(child)
            return child.handle(with: option)
        default: break
        }

        return true
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                print("Basic child Coordinator removed")
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    // MARK: - MainViewButtonClickDelegate
    func pushChild() {
        let data = ChildViewData(data: 0)
        print("Basic child Coordinator added with data \(data)")
        let child = BasicChildCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.onDataChanged = { data in
            print("Basic Coordinator received modified data \(data)")
        }
        child.startPush(viewData: data)
    }

    func presentChild() {
        let data = ChildViewData(data: 0)
        print("Basic child Coordinator added with data \(data)")
        let child = BasicChildCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.onDataChanged = { data in
            print("Basic Coordinator received modified data \(data)")
        }
        child.startPresent(viewData: data)
    }

    func presentChildOfChild(with url: URL?) {
        _ = handle(with: .childOfChild(url))
    }

    func callDeeplinkExample() {
        let url = URL(string: "deeplink-example://google.com/")!
        print("calling deeplink \(url)")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
