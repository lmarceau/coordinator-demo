//
//  SelfDeallocMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class SelfDeallocMainCoordinator: Coordinator, MainViewButtonClickDelegate {
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MainViewController()
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: false)
    }

    func start(with option: DeepLinkOption?) {
        guard let option = option else { return }
        switch option {
        case .main: break // do nothing in this case
        case .child: pushChild()
        default:
            // No child, cannot recursively search for deeplink options
            break
//            childCoordinators.forEach { coordinator in
//                coordinator.start(with: option)
//            }
        }
    }

    // MARK: - MainViewButtonClickDelegate
    func pushChild() {
        let data = ChildViewData(data: 7)
        print("SelfDealloc child Coordinator added with data \(data)")
        let child = SelfDeallocChildCoordinator(navigationController: navigationController!)
        child.onDataChanged = { data in
            print("SelfDealloc Coordinator received modified data \(data)")
        }
        child.startWithPush(data: data)
    }

    func presentChild() {
        let data = ChildViewData(data: 7)
        print("SelfDealloc child Coordinator added with data \(data)")
        let child = SelfDeallocChildCoordinator(navigationController: navigationController!)
        child.onDataChanged = { data in
            print("SelfDealloc Coordinator received modified data \(data)")
        }
        child.startWithPresent(data: data)
    }

    func presentChildOfChild(with url: URL?) {
        start(with: .childOfChild(url))
    }

    func callDeeplinkExample() {
        let url = URL(string: "deeplink-example://google.com/")!
        print("calling deeplink \(url)")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
