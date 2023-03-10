//
//  BasicChildOfChildPresentedVC.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-10.
//


import UIKit

class BasicChildOfChildPresentedVC: UIViewController {

    weak var coordinator: BasicChildOfChildCoordinator?
    var url: URL?

    init(url: URL?) {
        print("Child of child presented with url \(String(describing: url))")
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinish()
    }
}
