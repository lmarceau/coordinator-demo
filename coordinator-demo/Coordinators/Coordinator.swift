//
//  Coordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
    func handle(with option: DeepLinkOption) -> Bool
}

// Empty extensions since each coordinator method have their own way of handling
// This is to make it easier to implement, but this normally wouldn't be there in an application
extension Coordinator {
    func start() {}
//    func start(with option: DeepLinkOption?) -> Bool {}
}
