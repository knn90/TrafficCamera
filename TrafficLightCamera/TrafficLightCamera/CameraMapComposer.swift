//
//  CameraMapComposer.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import DomainFramework

class CameraMapComposer {
    static func cameraMapComposeWith(loader: Loader) -> CameraMapViewController {
        let presentationAdapter = CameraMapLoaderPresentationAdapter(cameraLoader: MainQueueDispatchDecorator(decoratee: loader))
        let cameraMapViewController = ViewControllerFactory.viewController(for: CameraMapViewController.self)
        cameraMapViewController.delegate = presentationAdapter
        
        presentationAdapter.presenter = CameraPresenter(
            loadingView: WeakRefVirtualProxy(cameraMapViewController),
            errorView: WeakRefVirtualProxy(cameraMapViewController),
            teamView: WeakRefVirtualProxy(cameraMapViewController))
        return cameraMapViewController
    }
}
