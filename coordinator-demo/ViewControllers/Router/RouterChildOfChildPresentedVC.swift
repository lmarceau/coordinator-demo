//
//  RouterChildOfChildPresentedVC.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-14.
//

import UIKit

class RouterChildOfChildPresentedVC: UIViewController {

    weak var coordinator: RouterChildOfChildCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }

    deinit {
        print("RouterChildOfChildPresentedVC deinit")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
