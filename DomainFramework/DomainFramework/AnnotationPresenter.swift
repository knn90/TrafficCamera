//
//  AnnotationPresenter.swift
//  DomainFramework
//
//  Created by Khoi Nguyen on 20/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import Foundation

public protocol AnnotationView {
    associatedtype Image
    
    func display(image: Image?)
}

public class AnnotationPresenter<View: AnnotationView, Image> where View.Image == Image {
    private let annotationView: View
    private let imageTransformer: (Data) -> Image?
    
    public init(annotationView: View, imageTransformer: @escaping (Data) -> Image?) {
        self.annotationView = annotationView
        self.imageTransformer = imageTransformer
    }
    
    public func didFinishLoadingImageWith(data: Data) {
        let image = imageTransformer(data)
        annotationView.display(image: image)
    }
}
