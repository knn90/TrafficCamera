//
//  CameraViewAdapter.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 20/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import DomainFramework
import MapKit

class CameraViewAdapter: CameraView {
    private weak var controller: CameraMapViewController?
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader, controller: CameraMapViewController) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(cameras: [Camera]) {
        controller?.display(cameraAnnotationControllers: cameras.map { camera in
            let presentationAdapter = AnnotationLoaderPresentationAdapter<CameraAnnotationController, UIImage>(imageLoader: imageLoader)
            let annotation = CameraAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: camera.location.latitude,
                    longitude: camera.location.longitude),
                url: URL(string: camera.image))
            let controller = CameraAnnotationController(annotation: annotation,
            delegate: presentationAdapter)
            presentationAdapter.presenter = AnnotationPresenter(annotationView: controller, imageTransformer: UIImage.init)
            return controller
        })
    }
}
