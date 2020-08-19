//
//  CameraPresenter.swift
//  DomainFramework
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation

public protocol LoadingView {
    func display(isLoading: Bool)
}

public protocol ErrorViewType {
    func display(errorMessage: String?)
}

public protocol CameraView {
    func display(cameras: [Camera])
}

public class CameraPresenter {
    private let loadingView: LoadingView
    private let errorView: ErrorViewType
    private let cameraView: CameraView
    private let loadTeamErrorMessage = "Cannot connect to server. Please try again later"
    
    public init(loadingView: LoadingView, errorView: ErrorViewType, teamView: CameraView) {
        self.loadingView = loadingView
        self.errorView = errorView
        self.cameraView = teamView
    }
    
    public func didStartLoadingCameras() {
        loadingView.display(isLoading: true)
        errorView.display(errorMessage: nil)
    }
    
    public func didFinishLoading(with error: Error) {
        loadingView.display(isLoading: false)
        errorView.display(errorMessage: loadTeamErrorMessage)
    }
    
    public func didFinishLoading(with cameras: [Camera]) {
        loadingView.display(isLoading: false)
        cameraView.display(cameras: cameras)
    }
}
