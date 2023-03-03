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

    /// TODO: Laurie
    case navigationControllerDelegate
}
