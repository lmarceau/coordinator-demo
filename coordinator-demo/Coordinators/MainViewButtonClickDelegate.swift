//
//  MainCoordinator.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import Foundation

protocol MainViewButtonClickDelegate: AnyObject {
    func pushChild()
    func presentChild()
    func presentChildOfChild(with url: URL?)
    func callDeeplinkExample()
}
