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
///
/// `Presentable` can be a Router or a ViewController that we want to present
/// `Module`: a `Presentable` that can be presented, pushed or dismissed from the stack
protocol Router: AnyObject, Presentable, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    /// The navigation controller of the router which is used for pushing and presenting `Presentable` modules
    var navigationController: NavigationController { get }

    /// The root view controller of the navigation controller, which is the first view controller on the navigation controller stack
    var rootViewController: UIViewController? { get }

    /// Present a module for a vertical flow.
    /// - Parameters:
    ///   - module: The presentable module to present
    ///   - animated: true means it will be animated
    func present(_ module: Presentable, animated: Bool, completion: (() -> Void)?)

    /// Dismiss a modile
    /// - Parameters:
    ///   - animated: true means it will be animated
    ///   - completion: The completion to call once the module is dismissed
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    /// When a Presentable type is pushed, we gain access to the view controller to be pushed using the module.toPresentable() and store the completion
    /// handler in a dictionary with the key being the view controller. UINavigationController presentables cannot be pushed unto the stack. The pushed module
    /// will be on an horizontal flow.
    /// - Parameters:
    ///   - module: The presentable module to push
    ///   - animated: true means it will be animated
    ///   - completion: the completion that will be called when dismissing the module
    func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?)

    /// When a view controller is popped, either from the back button, the navigation controller delegate function determines which view controller was popped
    /// and executes the corresponding completion handler.
    /// - Parameter animated: true means it will be animated
    func popModule(animated: Bool)

    /// Set the root module
    /// - Parameters:
    ///   - module: The module to set as root
    ///   - hideBar: Hide the navigation bar or not
    func setRootModule(_ module: Presentable, hideBar: Bool)

    /// Pop to the root module that was set with `setRootModule`
    /// - Parameter animated: true means it will be animated
    func popToRootModule(animated: Bool)
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

    func present(_ module: Presentable, animated: Bool = true, completion: (() -> Void)? = nil) {
        if let completion = completion {
            completions[module.toPresentable()] = completion
        }

        module.toPresentable().presentationController?.delegate = self
        navigationController.present(module.toPresentable(), animated: animated, completion: nil)
    }

    func dismissModule(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    func push(_ module: Presentable, animated: Bool = true, completion: (() -> Void)? = nil) {
        let controller = module.toPresentable()

        // Avoid pushing UINavigationController onto stack
        guard controller is UINavigationController == false else {
            return
        }

        if let completion = completion {
            completions[controller] = completion
        }

        navigationController.pushViewController(controller, animated: animated)
    }

    func popModule(animated: Bool = true)  {
        if let controller = navigationController.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    func setRootModule(_ module: Presentable, hideBar: Bool = false) {
        // Call all completions so all coordinators can be deallocated
        completions.forEach { $0.value() }
        navigationController.setViewControllers([module.toPresentable()], animated: false)
        navigationController.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = navigationController.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }

    // MARK: Presentable

    func toPresentable() -> UIViewController {
        return navigationController
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
