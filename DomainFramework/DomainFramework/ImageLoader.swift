//
//  ImageLoader.swift
//  DomainFramework
//
//  Created by Khoi Nguyen on 20/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

public protocol ImageLoader {
    typealias Result = Swift.Result<Data, Error>
    func load(url: URL, completion: @escaping (Result) -> Void)
}

public class CameraImageLoader: ImageLoader {

    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case generalError
        case invalidData
    }
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func load(url: URL, completion: @escaping (ImageLoader.Result) -> Void) {
        client.request(from: url) { result in
            switch result {
            case let .success(data, response):
                guard response.statusCode == 200 else {
                    return completion(.failure(Error.invalidData))
                }
                completion(.success(data))
            case .failure:
                completion(.failure(Error.generalError))
            }
            
        }
    }
}

