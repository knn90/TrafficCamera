//
//  CameraMapViewControllerTests.swift
//  TrafficLightCameraTests
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import XCTest
import DomainFramework

@testable import TrafficLightCamera

class CameraMapViewControllerTests: XCTestCase {
    func test_loadView_hasZeroCamerasOnMap() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.cameras.count, 0)
    }

    
    //MARK: - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> CameraMapViewController {
        let sut = CameraMapViewController()
        
        tracksForMemoryLeak(sut, file: file, line: line)
        
        return sut
    }
}
