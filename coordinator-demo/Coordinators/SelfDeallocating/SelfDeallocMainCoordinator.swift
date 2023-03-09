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

    // MARK: - MainViewButtonClickDelegate
    func button1Clicked() {
        let data = ChildViewData(data: 7)
        print("SelfDealloc child Coordinator added with data \(data)")
        let child = SelfDeallocChildCoordinator(navigationController: navigationController!)
        child.onDataChanged = { data in
            print("SelfDealloc Coordinator received modified data \(data)")
        }
        child.start(data: data)
    }
}
