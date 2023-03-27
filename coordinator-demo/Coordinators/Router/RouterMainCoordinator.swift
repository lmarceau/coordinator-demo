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
        router.setRootViewController(mainViewController, hideBar: false)
    }

    override func handle(with option: DeepLinkOption) -> Bool {
        let isHandled = super.handle(with: option)
        guard !isHandled else { return isHandled }

        // If not existing, check if we should support the deeplink
        // return false if not handled, or true if handled
        switch option {
        case .child: pushChild()
        case .childOfChild:
            let child = RouterChildPushCoordinator(router: router)
            addChild(child)
            return child.handle(with: option)
        default: break
        }

        return true
    }

    // MARK: - MainViewButtonClickDelegate
    func pushChild() {
        let data = ChildViewData(data: 5)
        print("Router child Coordinator added with data \(data)")
        let coordinator = RouterChildPushCoordinator(router: router)
        coordinator.onDataChanged = { data in
            print("Router Coordinator received modified data \(data)")
        }

        addChild(coordinator)
        coordinator.start(data: data) { [weak self] in
            self?.removeChild(coordinator)
            print("Router child Coordinator removed")
        }
    }

    func presentChild() {
        let data = ChildViewData(data: 5)
        print("Router child Coordinator added with data \(data)")
        let coordinator = RouterChildPresentCoordinator(router: router)
        coordinator.onDataChanged = { data in
            print("Router Coordinator received modified data \(data)")
        }

        addChild(coordinator)
        coordinator.start(data: data) { [weak self] in
            self?.removeChild(coordinator)
            print("Router child Coordinator removed")
        }
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
