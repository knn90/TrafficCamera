//
//  URLFactory.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation

class URLFactory {
    private static let baseURL = "https://api.data.gov.sg/v1/transport/traffic-images"
    
    static func makeCameraMapURL(timestamp: String) -> URL {
        return URL(string: URLFactory.baseURL + "?date_time=\(timestamp)")!
    }
}
