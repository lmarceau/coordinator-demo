//
//  ChildViewData.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-09.
//

import Foundation

// Simulating that the child view needs data from the main view controller
// and returns it modified
struct ChildViewData {
    var data: Int

    func addData() -> ChildViewData {
        return ChildViewData(data: self.data + 1)
    }
}
