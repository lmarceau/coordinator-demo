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
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        sceneCoordinator = SceneCoordinator(window: window)
        sceneCoordinator?.start()
    }
}

