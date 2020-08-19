//
//  HTTPClient.swift
//  NetworkingFramework
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func request(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
