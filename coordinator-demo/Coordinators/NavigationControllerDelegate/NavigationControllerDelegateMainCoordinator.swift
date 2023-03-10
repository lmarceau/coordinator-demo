//
//  NavigationControllerDelegateMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class NavigationControllerDelegateMainCoordinator: NSObject,
                                                    Coordinator,
                                                    MainViewButtonClickDelegate,
                                                    UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self

        let viewController = MainViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                print("NavigationControllerDelegate Coordinator removed")
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    // MARK: - MainViewButtonClickDelegate
    func button1Clicked() {
        let data = ChildViewData(data: 3)
        print("NavigationControllerDelegate Coordinator added with data \(data)")
        let child = NavigationControllerDelegateChildCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.onDataChanged = { data in
            print("NavigationControllerDelegate Coordinator received modified data \(data)")
        }
        child.startPush(data: data)
    }

    func button2Clicked() {
        let data = ChildViewData(data: 3)
        print("NavigationControllerDelegate Coordinator added with data \(data)")
        let child = NavigationControllerDelegateChildCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.onDataChanged = { data in
            print("NavigationControllerDelegate Coordinator received modified data \(data)")
        }
        child.startPresent(data: data)
    }

    func button3Clicked() {
        print("not implemented yet")
    }

    func button4Clicked() {
        let url = URL(string: "deeplink-example://google.com/")!
        print("calling deeplink \(url)")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let navViewController = fromViewController as? NavControllerDelegatePresentedViewController {
            // We're popping a NavControllerDelegate view controller; end its coordinator
            childDidFinish(navViewController.coordinator)
        }
    }
}
