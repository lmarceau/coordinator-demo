//
//  RouterMainCoordinatorTests.swift
//  coordinator-demoTests
//
//  Created by Laurie Marceau on 2023-03-14.
//

import XCTest
@testable import coordinator_demo

final class RouterMainCoordinatorTests: XCTestCase {
    var navigationController: NavigationController!
    var router: DefaultRouter!

    override func setUp() {
        super.setUp()
        navigationController = MockNavigationController()
        router = DefaultRouter(navigationController: navigationController)
    }

    override func tearDown() {
        super.tearDown()
        navigationController = nil
        router = nil
    }

    func testPushChild() {
        let subject = RouterMainCoordinator(router: router)
        subject.pushChild()

        XCTAssertTrue(subject.childCoordinators[0] is RouterChildPushCoordinator)
    }

    func testPresentChild() {
        let subject = RouterMainCoordinator(router: router)
        subject.presentChild()

        XCTAssertTrue(subject.childCoordinators[0] is RouterChildPresentCoordinator)
    }

    // TODO: do the rest of the tests
}
