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

protocol CameraMapViewControllerDelegate: class {
    func didRequestForCameras()
}

class CameraMapViewController: UIViewController, LoadingView, ErrorViewType {
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorViewContainter: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    weak var delegate: CameraMapViewControllerDelegate?
    var cameras = [Camera]()
    
    private let defaultCoordinate = CLLocationCoordinate2D(latitude: 1.28967, longitude: 103.85007)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setCenter(defaultCoordinate, animated: true)
        delegate?.didRequestForCameras()
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func display(errorMessage: String?) {
        errorLabel.text = errorMessage
        errorViewContainter.isHidden = false
    }
}
