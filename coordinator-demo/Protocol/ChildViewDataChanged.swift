//
//  ChildViewDataChanged.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-09.
//

import Foundation

// A protocol to exemplify passing data around view controllers with the coordinators
protocol ChildViewDataChanged: AnyObject {
    func dataHasChanged(data: ChildViewData)
}
