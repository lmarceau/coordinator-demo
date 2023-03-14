//
//  RouterMainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class RouterMainCoordinator: RouterCoordinator, MainViewButtonClickDelegate {

    lazy var mainViewController = MainViewController()

    override init(router: Router) {
        super.init(router: router)
        mainViewController.coordinator = self
        router.setRootModule(mainViewController, hideBar: false)
    }

    override func handle(with option: DeepLinkOption) -> Bool {
        switch option {
        case .main: break // do nothing in this case
        case .child: pushChild()
        default:
            break
//            childCoordinators.forEach { coordinator in
//                coordinator.start(with: option)
//            }
        }
        return true
    }

    // MARK: - MainViewButtonClickDelegate
    func pushChild() {
        let data = ChildViewData(data: 5)
        print("Router child Coordinator added with data \(data)")
        let coordinator = RouterChildPushCoordinator(router: router, data: data)
        coordinator.onDataChanged = { data in
            print("Router Coordinator received modified data \(data)")
        }

        // Maintain a strong reference to avoid deallocation
        addChild(coordinator)
        coordinator.start()

        // Avoid retain cycles and don't forget to remove the child when popped
        router.push(coordinator, animated: true) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
            print("Router child Coordinator removed")
        }
    }

    func presentChild() {
        let data = ChildViewData(data: 5)
        print("Router child Coordinator added with data \(data)")
        let coordinator = RouterChildPresentCoordinator(router: router, data: data)
        coordinator.onDataChanged = { data in
            print("Router Coordinator received modified data \(data)")
        }

        addChild(coordinator)
        coordinator.start()
        router.present(coordinator, animated: true)
    }

    func presentChildOfChild(with url: URL?) {
        handle(with: .childOfChild(url))
    }

    func callDeeplinkExample() {
        let url = URL(string: "deeplink-example://google.com/")!
        print("calling deeplink \(url)")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
