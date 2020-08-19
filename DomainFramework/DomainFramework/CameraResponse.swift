//
//  CameraResponse.swift
//  NetworkingFramework
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation

public struct CameraResponse: Decodable, Equatable {
    var items: [CameraItem]
}

public struct CameraItem: Decodable, Equatable {
    var timestamp: String
    var cameras: [Camera]
}

public struct Camera: Decodable, Equatable {
    var timestamp: String
    var image: String
    var location: Location
    var cameraId: String
    var imageMetaData: ImageMetaData
    
    public init(timestamp: String, image: String, location: Location, cameraId: String, imageMetaData: ImageMetaData) {
        self.timestamp = timestamp
        self.image = image
        self.location = location
        self.cameraId = cameraId
        self.imageMetaData = imageMetaData
    }
}

public struct Location: Decodable, Equatable {
    var latitude: Double
    var longitude: Double
    
    public init(latitude: Double, longitude: Double) {
           self.latitude = latitude
           self.longitude = longitude
       }
}

public struct ImageMetaData: Decodable, Equatable {
    var height: Int
    var width: Int
    var md5: String
    
    public init(height: Int, width: Int, md5: String) {
        self.height = height
        self.width = width
        self.md5 = md5
    }
}