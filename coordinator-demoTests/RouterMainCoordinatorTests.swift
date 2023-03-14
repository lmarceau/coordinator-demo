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

    func testPushChild() {
        let subject = RouterMainCoordinator(router: router)
        subject.pushChild()

        XCTAssertTrue(subject.childCoordinators[0] is RouterChildPushCoordinator)
        XCTAssertEqual(router.pushCalled, 1)
    }

    // TODO: do the rest of the tests
}
