//
//  CameraMapLoaderPresentationAdapter.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import DomainFramework

class CameraMapLoaderPresentationAdapter: CameraMapViewControllerDelegate {
    private let cameraLoader: Loader
    var presenter: CameraPresenter?
    
    init(cameraLoader: Loader) {
        self.cameraLoader = cameraLoader
    }
    
    func didRequestForCameras() {
        
    }
}
