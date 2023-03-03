//
//  CoordinatorType.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import Foundation

enum CoordinatorType {
    /// This solution works when navigating backwards to a previous view controller with simple object,
    /// but doesn't support multiple view controllers being shown in the child coordinator.
    /// viewDidDisappear() will be called prematurely, and our coordinator stack will get confused.
    case basic

    /// Involves extending the coordinator to become the navigation controller delegate, and then handling deallocation when this delegate method fires.
    case navigationControllerDelegate

    /// We keep reference of closures to execute foreach UIViewController pushed forward to deallocate matching Coordinator when navigating back.
    case router
}
