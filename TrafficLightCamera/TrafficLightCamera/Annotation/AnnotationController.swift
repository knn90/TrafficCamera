//
//  AnnotationController.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 20/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import DomainFramework
import MapKit

protocol CameraAnnotationControllerDelegate: class {
    func didRequestImage(url: URL)
}

class CameraAnnotationController: AnnotationView {
    typealias Image = UIImage
    
    let annotation: CameraAnnotation
    private var delegate: CameraAnnotationControllerDelegate?
    private var annotationView: MKMarkerAnnotationView?
    
    init(annotation: CameraAnnotation, delegate: CameraAnnotationControllerDelegate?) {
        self.annotation = annotation
        self.delegate = delegate
    }
    
    func view(in mapView: MKMapView) -> MKAnnotationView {
        let identifier = String(describing: CameraAnnotation.self)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
        if let markerAnnotationView = view as? MKMarkerAnnotationView {
            markerAnnotationView.animatesWhenAdded = true
            markerAnnotationView.canShowCallout = true
            markerAnnotationView.markerTintColor = UIColor.purple
            annotationView = markerAnnotationView
            return markerAnnotationView
            
        }
        return view
    }
    
    func requestImage() {
        guard let url = annotation.url else { return }
        delegate?.didRequestImage(url: url)
    }
    
    func display(image: UIImage?) {
        annotationView?.detailCalloutAccessoryView = UIImageView(image: image)
    }
}
