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
    weak var delegate: ChildViewDataChanged?
    var data: ChildViewData

    init(data: ChildViewData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.dataHasChanged(data: data.addData())
    }
}
