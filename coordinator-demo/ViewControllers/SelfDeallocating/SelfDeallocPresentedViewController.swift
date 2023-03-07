//
//  SelfDeallocPresentedViewController.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-07.
//

import UIKit

class SelfDeallocPresentedViewController: UIViewController {

    // Strong reference to coordinator to hold it until the VC is popped from the view hierarchy
    var coordinator: SelfDeallocChildCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
    }
}
