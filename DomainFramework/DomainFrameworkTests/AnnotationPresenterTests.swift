//
//  AnnotationPresenterTests.swift
//  DomainFrameworkTests
//
//  Created by Khoi Nguyen on 20/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import XCTest
import DomainFramework

class AnnotationPresenterTests: XCTestCase {
    func test_init_doNotSendAnyMessageToView() {
        let (_, view) = makeSUT()
        
        XCTAssertFalse(view.isDisplayCalled)
    }
    
    func test_didFinishLoadingImage_shouldCallDisplayImage() {
        let (sut, view) = makeSUT()
        sut.didFinishLoadingImageWith(data: Data())
        
        XCTAssertTrue(view.isDisplayCalled)
    }
    
    //MARK: - Helpers
    private func makeSUT(
        imageTransformer: @escaping (Data) -> AnyImage? = { _ in nil },
        file: StaticString = #file,
        line: UInt = #line) -> (AnnotationPresenter<ViewSpy, AnyImage>, ViewSpy) {
        let view = ViewSpy()
        let sut = AnnotationPresenter(annotationView: view, imageTransformer: imageTransformer)
        
        tracksForMemoryLeak(sut, file: file, line: line)
        tracksForMemoryLeak(view, file: file, line: line)
        
        return (sut, view)
    }
    
    private struct AnyImage {}
    
    private class ViewSpy: AnnotationView {
        typealias Image = AnyImage
        private(set) var isDisplayCalled = false
        
        func display(image: AnnotationPresenterTests.AnyImage?) {
            isDisplayCalled = true
        }
    }
}
