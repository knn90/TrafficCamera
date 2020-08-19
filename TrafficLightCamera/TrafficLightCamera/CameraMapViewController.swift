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

class CameraMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var cameras = [Camera]()
    private let defaultCoordinate = CLLocationCoordinate2D(latitude: 1.28967, longitude: 103.85007)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setCenter(defaultCoordinate, animated: true)
        
    }
}
