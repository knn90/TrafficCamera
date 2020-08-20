//
//  SceneDelegate.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import UIKit
import DomainFramework
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let client = URLSessionHTTPClient(session: URLSession.shared)
        let url = URLFactory.makeCameraMapURL(timestamp: "2020-05-16T05:50:06")
        let loader = CameraLoader(client: client, url: url)
        let imageLoader = CameraImageLoader(client: client)
        let cameraMapViewController = CameraMapComposer.cameraMapComposeWith(loader: loader, imageLoader: imageLoader)
        let navigationController = UINavigationController(rootViewController: cameraMapViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

