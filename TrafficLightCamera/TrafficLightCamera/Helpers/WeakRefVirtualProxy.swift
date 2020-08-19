//
//  WeakRefVirtualProxy.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import DomainFramework

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: CameraView where T: CameraView {
    func display(cameras: [Camera]) {
        object?.display(cameras: cameras)
    }
}

extension WeakRefVirtualProxy: ErrorViewType where T: ErrorViewType {
    func display(errorMessage: String?) {
        object?.display(errorMessage: errorMessage)
    }
}

extension WeakRefVirtualProxy: LoadingView where T: LoadingView {
    func display(isLoading: Bool) {
        object?.display(isLoading: isLoading)
    }
}
