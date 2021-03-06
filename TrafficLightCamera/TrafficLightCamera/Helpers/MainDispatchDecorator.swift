//
//  MainDispatchDecorator.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import DomainFramework

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}

extension MainQueueDispatchDecorator: Loader where T == Loader {
    func load(completion: @escaping (Loader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainQueueDispatchDecorator: ImageLoader where T == ImageLoader {
   
    func load(url: URL, completion: @escaping (ImageLoader.Result) -> Void) {
        decoratee.load(url: url) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
