//
//  CameraPresenterTests.swift
//  DomainFrameworkTests
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import XCTest
import DomainFramework

class CameraPresenterTests: XCTestCase {
    func test_init_doNotSendAnyMessageToView() {
        let (_, view) = makeSUT()
        
        XCTAssertEqual(view.messages, [])
    }
    
    func test_didStartLoadingTeam_displayNoErrorMessageAndStartLoading() {
        let (sut, view) = makeSUT()
        
        sut.didStartLoadingCameras()
        
        XCTAssertEqual(view.messages, [.display(isLoading: true), .display(errorMessage: nil)])
    }
    
    func test_didFinishLoadingTeamWithError_displayErrorMessageAndStopLoading() {
        let (sut, view) = makeSUT()
        let error = NSError(domain: "any", code: 0)
        let errorMessage = "Cannot connect to server. Please try again later"
        
        sut.didFinishLoading(with: error)
        
        XCTAssertEqual(view.messages, [.display(isLoading: false), .display(errorMessage: errorMessage)])
    }
    
    func test_didFinishLoadingTeam_displayTeamsAndStopLoading() {
        let (sut, view) = makeSUT()
        let cameras = [CameraFactory.anyCamera(), CameraFactory.anyCamera()]
        sut.didFinishLoading(with: cameras)
        
        XCTAssertEqual(view.messages, [.display(isLoading: false), .display(cameras: cameras)])
    }
    
    //MARK: - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (CameraPresenter, ViewSpy) {
        let view = ViewSpy()
        let sut = CameraPresenter(loadingView: view, errorView: view, teamView: view)
        
        tracksForMemoryLeak(sut, file: file, line: line)
        tracksForMemoryLeak(view, file: file, line: line)
        
        return (sut, view)
    }
    private class ViewSpy: LoadingView, ErrorViewType, CameraView {
        enum Message: Equatable {
            case display(errorMessage: String?)
            case display(isLoading: Bool)
            case display(cameras: [Camera])
        }
        
        var messages = [Message]()
        
        func display(isLoading: Bool) {
            messages.append(.display(isLoading: isLoading))
        }
        
        func display(errorMessage: String?) {
            messages.append(.display(errorMessage: errorMessage))
        }
        
        func display(cameras: [Camera]) {
            messages.append(.display(cameras: cameras))
        }
    }
}
