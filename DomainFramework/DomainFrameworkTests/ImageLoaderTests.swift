//
//  ImageLoaderTests.swift
//  DomainFrameworkTests
//
//  Created by Khoi Nguyen on 20/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import XCTest
import DomainFramework

class ImageLoaderTests: XCTestCase {
    func test_init_shouldNotSendAnyRequest() {
        let (_, client) = makeSUT()
        
        XCTAssertEqual(client.requestedURL, [])
    }
    
    func test_load_shouldRequestDataFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT()
        
        sut.load(url: url) { _ in }
        
        XCTAssertEqual(client.requestedURL, [url])
    }
    
    func test_load_shouldReturnFailureOnClientError() {
        let (sut, client) = makeSUT()
        let error = NSError(domain: "any", code: 0)
        
        expect(sut: sut, toLoadURL: anyURL(), toCompleteLoadingWithResult: .failure(CameraImageLoader.Error.generalError), when: {
            client.completeRequest(withError: error)
        })
    }
    
    func test_load_shouldReturnFailureOnNon200HTTPReponse() {
        let (sut, client) = makeSUT()
        let statusCodes = [199, 201, 300, 400, 500]
        
        statusCodes.enumerated().forEach { index, code in
            expect(sut: sut, toLoadURL: anyURL(), toCompleteLoadingWithResult: .failure(CameraImageLoader.Error.invalidData), when: {
                client.completeRequest(withStatusCode: code, at: index)
            })
        }
    }
    
    //MARK: - Helpers
    private func makeSUT(url: URL? = nil) -> (sut: CameraImageLoader, client: HTTPClientSpy) {
        
        let client = HTTPClientSpy()
        let sut = CameraImageLoader(client: client)
        
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURL: [URL] = []
        private var completions: [(HTTPClientResult) -> Void] = []
        func request(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            requestedURL.append(url)
            completions.append(completion)
        }
        
        func completeRequest(withStatusCode code: Int, data: Data = Data(), at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURL[index], statusCode: code, httpVersion: nil, headerFields: nil)!
            completions[index](.success(data, response))
        }
        
        func completeRequest(withError error: Error, at index: Int = 0) {
            completions[index](.failure(error))
        }
    }
    
    private func expect(sut: CameraImageLoader, toLoadURL url: URL, toCompleteLoadingWithResult expectedResult: ImageLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        sut.load(url: url) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedData), .success(expectedData)):
                XCTAssertEqual(receivedData, expectedData, file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError as NSError, expectedError as NSError, file: file, line: line)
            default:
                XCTFail("Expected to get \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1.0)
    }
    
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
}
