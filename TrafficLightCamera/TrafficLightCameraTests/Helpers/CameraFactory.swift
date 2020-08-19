//
//  CameraFactory.swift
//  TrafficLightCameraTests
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import DomainFramework

class CameraFactory {
    static func anyCamera() -> Camera {
        return Camera(timestamp: "", image: "", location: LocationFactory.anyLocation(), cameraId: "\(UUID().hashValue)", imageMetaData: ImageMetaDataFactory.anyImageMetaData())
    }
}

class LocationFactory {
    static func anyLocation() -> Location {
        return Location(latitude: Double.random(in: 0..<100), longitude: Double.random(in: 0..<100))
    }
}

class ImageMetaDataFactory {
    static func anyImageMetaData() -> ImageMetaData {
        return ImageMetaData(height: Int.random(in: 0..<100), width: Int.random(in: 0..<100), md5: "any")
    }
}

