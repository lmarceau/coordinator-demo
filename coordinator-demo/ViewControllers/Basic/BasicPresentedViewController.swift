//
//  BasicPresentedViewController.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class BasicPresentedViewController: UIViewController {

    weak var coordinator: BasicChildCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinish()
    }
}
