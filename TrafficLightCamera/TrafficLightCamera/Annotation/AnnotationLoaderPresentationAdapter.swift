//
//  AnnotationLoaderPresentation.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 20/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation
import DomainFramework

class AnnotationLoaderPresentationAdapter<View: AnnotationView, Image>: CameraAnnotationControllerDelegate where View.Image == Image {
    
    private let imageLoader: ImageLoader
    var presenter: AnnotationPresenter<View, Image>?
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    func didRequestImage(url: URL) {
        imageLoader.load(url: url) { [weak self] result in
            switch result {
            case let .success(data):
                self?.presenter?.didFinishLoadingImageWith(data: data)
            case .failure: break
            }
        }
    }
}
