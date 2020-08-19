//
//  CameraMapViewControllerTests.swift
//  TrafficLightCameraTests
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import XCTest
import DomainFramework
import MapKit

@testable import TrafficLightCamera

class CameraMapViewControllerTests: XCTestCase {
    func test_init_hasZeroCamerasOnMap() {
        let (sut, _) = makeSUT()
        
        XCTAssertEqual(sut.cameras.count, 0)
    }
    
    func test_loadView_requestsForCameras() {
        let (sut, delegate) = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(delegate.messages, [.didRequestForCameras])
    }
    
    //MARK: - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (CameraMapViewController, CameraMapViewControllerDelegateSpy) {
        let sut = ViewControllerFactory.createViewController(for: CameraMapViewController.self) as! CameraMapViewController
        let delegate = CameraMapViewControllerDelegateSpy()
        sut.delegate = delegate
        
        tracksForMemoryLeak(sut, file: file, line: line)
        tracksForMemoryLeak(delegate, file: file, line: line)
        
        return (sut, delegate)
    }
    
    class CameraMapViewControllerDelegateSpy: CameraMapViewControllerDelegate {
        
        enum Message {
            case didRequestForCameras
        }
        
        var messages = [Message]()
        
        func didRequestForCameras() {
            messages.append(.didRequestForCameras)
        }
    }
}
