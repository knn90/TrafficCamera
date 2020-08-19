//
//  CameraMapViewController.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import UIKit
import DomainFramework
import MapKit

protocol CameraMapViewControllerDelegate {
    func didRequestForCameras()
}

class CameraMapViewController: UIViewController, LoadingView, ErrorViewType, CameraView {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorViewContainter: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var delegate: CameraMapViewControllerDelegate?
    var cameras = [Camera]()
    
    private let defaultCoordinate = CLLocationCoordinate2D(latitude: 1.28967, longitude: 103.85007)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Camera Map"
        setupMapView()
        delegate?.didRequestForCameras()
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
        }
    }
    
    func display(errorMessage: String?) {
        if let errorMessage = errorMessage {
            errorLabel.text = errorMessage
            errorViewContainter.isHidden = false   
        } else {
            errorLabel.text = nil
            errorViewContainter.isHidden = true
        }
    }
    
    func display(cameras: [Camera]) {
        self.cameras = cameras
        addAnnotationToMap(cameras: cameras)
    }
    
    private func setupMapView() {
        mapView.setCenter(defaultCoordinate, animated: true)
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: CameraAnnotation.self))
        mapView.delegate = self
    }
    
    private func addAnnotationToMap(cameras: [Camera]) {
        for camera in cameras {
            let annotation = CameraAnnotation(coordinate: CLLocationCoordinate2D(latitude: camera.location.latitude, longitude: camera.location.longitude))
            mapView.addAnnotation(annotation)
        }
    }
}

extension CameraMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = String(describing: CameraAnnotation.self)
        let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
        if let markerAnnotationView = view as? MKMarkerAnnotationView {
            markerAnnotationView.animatesWhenAdded = true
            markerAnnotationView.canShowCallout = true
            markerAnnotationView.markerTintColor = UIColor.purple
            
            // Provide an image view to use as the accessory view's detail view.
            
            return markerAnnotationView
        }
        
        return view
    }
}
