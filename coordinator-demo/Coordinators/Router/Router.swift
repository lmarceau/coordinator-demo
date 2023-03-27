//
//  Router.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

/// The router should be able to perform all possible navigation actions.
/// It must also act as the delegate of the navigation controller so it can intercept back button presses and run the corresponding
/// completion handler for the view controller that was popped.
protocol Router: AnyObject, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    /// The navigation controller of the router which is used for pushing and presenting view controllers
    var navigationController: NavigationController { get }

    /// The root view controller of the navigation controller, which is the first view controller on the navigation controller stack
    var rootViewController: UIViewController? { get }

    /// Present a view controller for a vertical flow.
    /// - Parameters:
    ///   - viewController: The view controller to present
    ///   - animated: true means it will be animated
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    /// Dismiss a view controller
    /// - Parameters:
    ///   - animated: true means it will be animated
    ///   - completion: The completion to call once the view controller is dismissed
    func dismiss(animated: Bool, completion: (() -> Void)?)

    /// When a ViewController is pushed for an horizontal flow, we store a completion handler in a dictionary with the key being the view controller, so we can call
    /// an action when the view controller is done with the presentation. We check to ensure we don't push navigation controllers.
    /// - Parameters:
    ///   - viewController: The view controller to push
    ///   - animated: true means it will be animated
    ///   - completion: the completion that will be called when dismissing the view controller
    func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)

    /// When a view controller is popped, either from the back button, the navigation controller delegate function determines which view controller was popped
    /// and executes the corresponding completion handler.
    /// - Parameter animated: true means it will be animated
    func popViewController(animated: Bool)

    /// Set the root view controller
    /// - Parameters:
    ///   - viewController: The view controller to set as root
    ///   - hideBar: Hide the navigation bar or not
    func setRootViewController(_ viewController: UIViewController, hideBar: Bool)

    /// Pop to the root view controller that was set with `setRootViewController`
    /// - Parameter animated: true means it will be animated
    func popToRootViewController(animated: Bool)
}

class DefaultRouter: NSObject, Router {
    private var completions: [UIViewController: () -> Void]

    var rootViewController: UIViewController? {
        return navigationController.viewControllers.first
    }

    let navigationController: NavigationController

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
        self.completions = [:]
        super.init()
        self.navigationController.delegate = self
    }

    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        if let completion = completion {
            completions[viewController] = completion
        }

        viewController.presentationController?.delegate = self
        navigationController.present(viewController, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    func push(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        // Avoid pushing UINavigationController onto stack
        guard viewController is UINavigationController == false else {
            return
        }

        if let completion = completion {
            completions[viewController] = completion
        }

        navigationController.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool = true)  {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func setRootViewController(_ viewController: UIViewController, hideBar: Bool = false) {
        // Call all completions so all coordinators can be deallocated
        completions.forEach { $0.value() }
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.isNavigationBarHidden = hideBar
    }

    func popToRootViewController(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }

    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController,
                              animated: Bool) {
        // Ensure the view controller is popping
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(poppedViewController) else {
            return
        }

        runCompletion(for: poppedViewController)
    }

    // MARK: - UIAdaptivePresentationControllerDelegate

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("presentationControllerDidDismiss")
        runCompletion(for: presentationController.presentedViewController)
    }
}
