//
//  CameraLoader.swift
//  NetworkingFramework
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation


public enum LoaderResult {
    case success(CameraResponse)
    case failure(Error)
}

public protocol Loader {
    func load(completion: @escaping (LoaderResult) -> Void)
}

public class CameraLoader: Loader {
    
    private let client: HTTPClient
    private let url: URL
    
    public enum Error: Swift.Error {
        case generalError
        case invalidData
    }
    
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    
    public func load(completion: @escaping (LoaderResult) -> Void) {
        client.request(from: url) { result in
            switch result {
            case let .success(data, response):
                guard let snapshot = try? JSONDecoder().decode(CameraResponse.self, from: data), response.statusCode == 200 else {
                    return completion(.failure(Error.invalidData))
                }
                completion(.success(snapshot))
            case .failure:
                completion(.failure(Error.generalError))
            }
            
        }
    }
}
