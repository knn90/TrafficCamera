//
//  CameraAnnotation.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import MapKit

class CameraAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let url: URL?
    
    init(coordinate: CLLocationCoordinate2D, url: URL?) {
        self.coordinate = coordinate
        self.url = url
    }
}
