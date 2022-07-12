//
//  MapViewController.swift
//  WaadsuTask
//
//  Created by Vladislav on 06.07.2022.
//

import UIKit
import SnapKit
import MapKit

class MapViewController: UIViewController {
    private let infoView = InfoView.loadFromNib()
    private let mapView = MKMapView()
    private let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private lazy var gestureController = MapViewGestureController(mapView: mapView)
    
    var interactor: MapInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.didLoad()
        gestureController.start()
        addLoader()
        addMapView()
        addInfoView()
    }
    
    func updateInfoView(by text: String) {
        infoView.configure(by: text)
    }
    
    private func addInfoView() {
        view.addSubview(infoView)
        infoView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

    private func addLoader() {
        loader.color = .white
        view.addSubview(loader)
        loader.startAnimating()
        loader.snp.makeConstraints {
            $0.width.height.equalTo(55)
            $0.center.equalToSuperview()
        }
    }
    
    private func addMapView() {
        mapView.alpha = 0
        view.addSubview(mapView)
        let coordinate = CLLocationCoordinate2D(latitude:  55.644466, longitude: 37.395744)
        let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: false)
        mapView.delegate = gestureController
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func showMapView() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseIn) {
            self.mapView.alpha = 1
        } completion: { _ in
            self.loader.removeFromSuperview()
        }
    }
    
    func add(polygon: MKPolygon) {
        mapView.addOverlay(polygon)
    }
}
