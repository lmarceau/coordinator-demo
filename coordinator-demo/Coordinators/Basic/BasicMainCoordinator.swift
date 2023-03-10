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
    func button1Clicked() {
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

    func button2Clicked() {
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

    func button3Clicked() {
        print("not implemented yet")
    }

    func button4Clicked() {
        let url = URL(string: "deeplink-example://google.com/")!
        print("calling deeplink \(url)")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
