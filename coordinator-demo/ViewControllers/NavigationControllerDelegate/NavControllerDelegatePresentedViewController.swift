//
//  NavControllerDelegatePresentedViewController.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class NavControllerDelegatePresentedViewController: UIViewController {

    weak var coordinator: NavigationControllerDelegateChildCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
    }
}
