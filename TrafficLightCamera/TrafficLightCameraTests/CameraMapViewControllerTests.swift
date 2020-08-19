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
    
    func test_loadView_displaysTitleAsCameraMap() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.title, "Camera Map")
    }
    
    func test_loadView_requestsForCameras() {
        let (sut, delegate) = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(delegate.messages, [.didRequestForCameras])
    }
    
    func test_displayIsLoading_showsLoadingIndicatorOnTrue() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        sut.display(isLoading: true)
        
        XCTAssertEqual(sut.isShowingLoadingIndicator, true)
    }
    
    func test_displayIsLoading_showsLoadingIndicatorOnFalse() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        sut.display(isLoading: false)
        
        XCTAssertEqual(sut.isShowingLoadingIndicator, false)
    }
    
    func test_displayError_showsErrorViewOnNonNilMessage() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        sut.display(errorMessage: "errorMessage")
        
        XCTAssertEqual(sut.errorMessage, "errorMessage")
        XCTAssertEqual(sut.isShowingError, true)
    }
    
    func test_displayError_hidesErrorViewOnNilMessage() {
        let (sut, _) = makeSUT()
        sut.loadViewIfNeeded()
        sut.display(errorMessage: nil)
        
        XCTAssertEqual(sut.errorMessage, nil)
        XCTAssertEqual(sut.isShowingError, false)
    }
    
    func test_displayCameras_updateCamerasArray() {
        let (sut, _) = makeSUT()
        let cameras = [CameraFactory.anyCamera(), CameraFactory.anyCamera()]
        sut.loadViewIfNeeded()
        sut.display(cameras: cameras)
        
        XCTAssertEqual(sut.cameras, cameras)
    }
    
    func test_displayCameras_renderAnnotationOnMap() {
        let (sut, _) = makeSUT()
        let firstCamera = CameraFactory.anyCamera()
        let secondCamera = CameraFactory.anyCamera()
        let cameras = [firstCamera, secondCamera]
        sut.loadViewIfNeeded()
        sut.display(cameras: cameras)
        
        XCTAssertEqual(sut.mapView.annotations.count, 2)
    }
    
    //MARK: - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (CameraMapViewController, CameraMapViewControllerDelegateSpy) {
        let sut = ViewControllerFactory.viewController(for: CameraMapViewController.self)
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

extension CameraMapViewController {
    var isShowingLoadingIndicator: Bool {
        return loadingIndicator.isAnimating && !loadingIndicator.isHidden
    }
    
    var errorMessage: String? {
        return errorLabel.text
    }
    
    var isShowingError: Bool {
        return !errorViewContainter.isHidden
    }
}
