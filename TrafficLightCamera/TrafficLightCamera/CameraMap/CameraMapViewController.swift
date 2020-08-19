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
        mapView.setCenter(defaultCoordinate, animated: true)
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
    
    private func addAnnotationToMap(cameras: [Camera]) {
        for camera in cameras {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: camera.location.latitude, longitude: camera.location.longitude)
            mapView.addAnnotation(annotation)
        }
    }
}
