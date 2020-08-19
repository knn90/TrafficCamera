//
//  ViewControllerFactory.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    private init() {}
    
    static func viewController<T>(for type: T.Type) -> T where T : UIViewController {
        return createViewController(for: type) as! T
    }
    
    static func createViewController(for classType: AnyClass) -> UIViewController {
        let bundle = Bundle(for: classType.self)
        let identifier = String(describing: classType.self)
        let storyboard = UIStoryboard(name: identifier, bundle: bundle)
        return storyboard.instantiateViewController(identifier: identifier)
    }
}
