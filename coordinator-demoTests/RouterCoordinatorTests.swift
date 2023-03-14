//
//  RouterCoordinatorTests.swift
//  coordinator-demoTests
//
//  Created by Laurie Marceau on 2023-03-14.
//

import XCTest
@testable import coordinator_demo

final class RouterCoordinatorTests: XCTestCase {
    var navigationController: NavigationController!
    var router: MockRouter!

    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        router = MockRouter(navigationController: navigationController)
    }

    override func tearDown() {
        super.tearDown()
        navigationController = nil
        router = nil
    }

    func testAddChild() {
        let subject = RouterCoordinator(router: router)
        let child = RouterCoordinator(router: router)
        subject.addChild(child)

        XCTAssertEqual(subject.childCoordinators[0], child)
    }

    func testRemoveChild() {
        let subject = RouterCoordinator(router: router)
        let child = RouterCoordinator(router: router)
        subject.addChild(child)
        subject.removeChild(child)

        XCTAssertTrue(subject.childCoordinators.isEmpty)
    }

    // TODO: do the rest of the tests
}

class MockRouter: NSObject, Router {
    var navigationController: NavigationController
    var rootViewController: UIViewController?

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    var presentCalled = 0
    func present(_ module: Presentable, animated: Bool) {
        presentCalled += 1
    }

    var dismissModuleCalled = 0
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        dismissModuleCalled += 1
    }

    var pushCalled = 0
    func push(_ module: Presentable, animated: Bool, completion: (() -> Void)?) {
        pushCalled += 1
    }

    var popModuleCalled = 0
    func popModule(animated: Bool) {
        popModuleCalled += 1
    }

    var setRootModuleCalled = 0
    func setRootModule(_ module: Presentable, hideBar: Bool) {
        setRootModuleCalled += 1
    }

    var popToRootModuleCalled = 0
    func popToRootModule(animated: Bool) {
        popToRootModuleCalled += 1
    }

    var viewControllerPresentable = UIViewController()
    func toPresentable() -> UIViewController {
        return viewControllerPresentable
    }
}
