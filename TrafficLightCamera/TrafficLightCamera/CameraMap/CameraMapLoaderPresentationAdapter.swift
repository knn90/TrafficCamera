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
        presenter?.didStartLoadingCameras()
        cameraLoader.load { [weak self] result in
            switch result {
            case let .success(response):
                if response.items.count > 0 {
                    self?.presenter?.didFinishLoading(with: response.items[0].cameras)
                } else {
                    self?.presenter?.didFinishLoading(with: [])
                }
            case let .failure(error):
                self?.presenter?.didFinishLoading(with: error)
            }
        }
    }
}
