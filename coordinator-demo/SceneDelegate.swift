//
//  SceneDelegate.swift
//  coordinator-demo
//
//  Created by Laurie Marceau on 2023-03-03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var sceneCoordinator: SceneCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        sceneCoordinator = SceneCoordinator(scene: scene)
        sceneCoordinator?.start()

        handleDeeplinkOrShortcutsAtLaunch(with: connectionOptions, on: scene)
    }

    /// Asks the delegate to open one or more URLs.
    func scene(_ scene: UIScene,
               openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }

        let deepLink = DeepLinkOption.build(with: url)
        sceneCoordinator?.start(with: deepLink)
    }

    /// Tells the delegate to handle the specified Handoff-related activity.
    /// Use this method to update the specified scene with the data from the provided activity object.
    /// UIKit calls this method on your app’s main thread only after it receives all of the data for an activity object, which might originate from a different device.
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        let deepLink = DeepLinkOption.build(with: userActivity)
        sceneCoordinator?.start(with: deepLink)
    }

    /// Asks the delegate to perform the user-selected action.
    /// When the user selects one of your app's shortcut items, use this method to perform the selected action.
    /// After you finish the action, execute the specified completionHandler block to report your success or failure in performing the action.
    func windowScene(_ windowScene: UIWindowScene,
                     shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        guard let deepLink = DeepLinkOption.build(with: shortcutItem) else {
            completionHandler(false)
            return
        }

        DispatchQueue.main.async {
            self.sceneCoordinator?.start(with: deepLink)
            completionHandler(true)
        }
    }

    private func handleDeeplinkOrShortcutsAtLaunch(
        with connectionOptions: UIScene.ConnectionOptions,
        on scene: UIScene
    ) {
        // We might receive several user activities so the URL, so we should account for this
        if let userActivity = connectionOptions.userActivities.first {
            self.scene(scene, continue: userActivity)
        } else if !connectionOptions.urlContexts.isEmpty {
            self.scene(scene, openURLContexts: connectionOptions.urlContexts)
        } else if let shortcutItem = connectionOptions.shortcutItem {
            let deepLink = DeepLinkOption.build(with: shortcutItem)
            sceneCoordinator?.start(with: deepLink)
        }
    }
}

