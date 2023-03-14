//
//  NavigationController.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-14.
//

import UIKit

protocol NavigationController: UIViewController {
    var viewControllers: [UIViewController] { get }
    var delegate: UINavigationControllerDelegate? { get set }
    var isNavigationBarHidden: Bool { get set }
    var transitionCoordinator: UIViewControllerTransitionCoordinator? { get }

    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool) -> UIViewController?
    func popToRootViewController(animated: Bool) -> [UIViewController]?
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool)
}

extension UINavigationController: NavigationController {}
