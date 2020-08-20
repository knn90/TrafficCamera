//
//  CameraMapViewController.swift
//  TrafficLightCamera
//
//  Created by Khoi Nguyen on 19/8/20.
//  Copyright © 2020 Khoi Nguyen. All rights reserved.
//

import UIKit
import DomainFramework
import MapKit

protocol CameraMapViewControllerDelegate {
    func didRequestForCameras()
}

class CameraMapViewController: UIViewController, LoadingView, ErrorViewType {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorViewContainter: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var delegate: CameraMapViewControllerDelegate?
    var annotationDic: [CameraAnnotation: CameraAnnotationController] = [:]
    
    private let defaultCoordinate = CLLocationCoordinate2D(latitude: 1.28967, longitude: 103.85007)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Camera Map"
        setupMapView()
        delegate?.didRequestForCameras()
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = true
        }
    }
    
    func display(errorMessage: String?) {
        if let errorMessage = errorMessage {
            errorLabel.text = errorMessage
            errorViewContainter.isHidden = false   
        } else {
            errorLabel.text = nil
            errorViewContainter.isHidden = true
        }
    }
    
    func display(cameraAnnotationControllers: [CameraAnnotationController]) {
        for controller in cameraAnnotationControllers {
            annotationDic[controller.annotation] = controller
            mapView.addAnnotation(controller.annotation)
        }
    }
    
    private func setupMapView() {
        mapView.setCenter(defaultCoordinate, animated: true)
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: CameraAnnotation.self))
        mapView.delegate = self
    }
}

extension CameraMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CameraAnnotation else { return nil }
        let controller = annotationDic[annotation]
        return controller?.view(in: mapView)
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let view = view as? MKMarkerAnnotationView, let annotation = view.annotation as? CameraAnnotation else { return }
        
        let controller = annotationDic[annotation]
        controller?.requestImage()
    }
    
}
