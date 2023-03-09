//
//  ChildViewDataChanged.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-09.
//

import Foundation

protocol ChildViewDataChanged: AnyObject {
    func dataHasChanged(data: ChildViewData)
}
