//
//  RouterTests.swift
//  coordinator-demoTests
//
//  Created by Laurie Marceau on 2023-03-14.
//

import XCTest
@testable import coordinator_demo

final class RouterTests: XCTestCase {
    var navigationController: MockNavigationController!
    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
    }

    override func tearDown() {
        super.tearDown()
        navigationController = nil
    }

    func testInitState() {
        let subject = DefaultRouter(navigationController: navigationController)
        XCTAssertNil(subject.rootViewController)
        XCTAssertEqual(subject.navigationController, navigationController)
    }

    func testPresentViewController() {
        let subject = DefaultRouter(navigationController: navigationController)
        let viewController = UIViewController()
        subject.present(viewController)

        XCTAssertEqual(navigationController.presentCalled, 1)
    }

    func testDismissModule() {
        let subject = DefaultRouter(navigationController: navigationController)
        subject.dismiss()

        XCTAssertEqual(navigationController.dismissCalled, 1)
    }

    func testPushModule_doesntPushNavigationController() {
        let subject = DefaultRouter(navigationController: navigationController)
        let navController = UINavigationController()
        subject.push(navController)

        XCTAssertEqual(navigationController.pushCalled, 0)
    }

    func testPushModule_pushViewController() {
        let subject = DefaultRouter(navigationController: navigationController)
        let viewController = UIViewController()
        subject.push(viewController)

        XCTAssertEqual(navigationController.pushCalled, 1)
    }

    // TODO: do the rest of the tests
}

class MockNavigationController: UIViewController, NavigationController {
    var viewControllers: [UIViewController] = []
    var delegate: UINavigationControllerDelegate?
    var isNavigationBarHidden: Bool = false

    var presentCalled = 0
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled += 1
    }

    var dismissCalled = 0
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCalled += 1
    }

    var pushCalled = 0
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushCalled += 1
    }

    var popViewCalled = 0
    func popViewController(animated: Bool) -> UIViewController? {
        popViewCalled += 1
        return nil
    }

    var popToRootCalled = 0
    func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootCalled += 1
        return nil
    }

    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        self.viewControllers = viewControllers
    }
}
