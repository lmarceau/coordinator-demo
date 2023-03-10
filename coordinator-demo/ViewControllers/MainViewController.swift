//
//  ViewController.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class MainViewController: UIViewController {

    weak var coordinator: MainViewButtonClickDelegate?

    struct UX {
        static let spaceBetweenButton: CGFloat = 24
    }

    lazy var button1: UIButton = .build { button in
        button.setTitle("Push VC for horizontal flow", for: .normal)
    }

    lazy var button2: UIButton = .build { button in
        button.setTitle("Present VC for vertical flow", for: .normal)
    }

    lazy var button3: UIButton = .build { button in
        button.setTitle("Present two level deep then back", for: .normal)
    }

    lazy var button4: UIButton = .build { button in
        button.setTitle("Deeplink test", for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        button1.addTarget(self, action: #selector(button1Clicked), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Clicked), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Clicked), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button4Clicked), for: .touchUpInside)

        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UX.spaceBetweenButton),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: UX.spaceBetweenButton),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: UX.spaceBetweenButton),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: UX.spaceBetweenButton),
            button4.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func button1Clicked() {
        coordinator?.button1Clicked()
    }

    @objc func button2Clicked() {
        coordinator?.button2Clicked()
    }

    @objc func button3Clicked() {
         coordinator?.button3Clicked()
    }

    @objc func button4Clicked() {
         coordinator?.button4Clicked()
    }
}

