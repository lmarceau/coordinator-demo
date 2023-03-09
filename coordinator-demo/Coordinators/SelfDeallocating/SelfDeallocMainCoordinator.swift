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
        print("SelfDealloc child Coordinator added")
        let child = SelfDeallocChildCoordinator(navigationController: navigationController!)
        // TODO: Laurie - test delegate to send back information
//        child.delegate = self
        // back button will be a problem, to pass back data
        child.start()
    }
}
