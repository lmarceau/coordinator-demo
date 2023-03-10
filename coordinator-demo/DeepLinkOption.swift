//
//  DeepLinkOption.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-10.
//

import UIKit
import CoreSpotlight

struct DeepLinkURLConstants {
    static let main = "main"
    static let child = "child"
    static let childOfChild = "childOfChild"
}

enum DeepLinkOption {
    case main
    case child
    case childOfChild(URL?) // example with a URL parameter

    static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
        if let url = userActivity.webpageURL {
            return .childOfChild(url)
        }

        if userActivity.activityType == CSSearchableItemActionType,
           let userInfo = userActivity.userInfo,
           let urlString = userInfo[CSSearchableItemActivityIdentifier] as? String,
           let url = URL(string: urlString) {
            return .childOfChild(url)
        }

        return nil
    }

    static func build(with url: URL) -> DeepLinkOption? {
        return .childOfChild(url)
    }

    static func build(with shortcutItem: UIApplicationShortcutItem) -> DeepLinkOption? {
        guard let last = shortcutItem.type.components(separatedBy: ".").last else { return nil }
        return last == "child" ? .child : nil
    }
}
