//
//  MapViewGestureController.swift
//  WaadsuTask
//
//  Created by Danil Kovalev on 11.07.2022.
//

import UIKit
import MapKit


// MARK: - Класс был создан с целью вынести из View логику работы с жестами
// И логику окраса регионов в цвета, соблюдая принцип Single Responsibility
//
class MapViewGestureController: NSObject, MKMapViewDelegate {
    private let mapView: MKMapView
    private var selectedPolygon: MKPolygon?
    init(mapView: MKMapView) {
        self.mapView = mapView
    }
    
    func start() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTouched(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let r = MKPolygonRenderer(overlay: overlay)
        r.lineWidth = 1
        r.strokeColor = .black
        r.fillColor = selectedPolygon == (overlay as? MKPolygon) ? UIColor.blue.withAlphaComponent(0.6) : UIColor.systemBlue.withAlphaComponent(0.3)
        return r
    }
    
    @objc private func mapViewTouched(_ recognizer: UITapGestureRecognizer) {
        let touchPoint = recognizer.location(in: mapView)
        let location = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let polygons = ((mapView.overlays as? [MKPolygon]) ?? [])
        
        selectedPolygon = polygons.first(where: { polygon in
            let renderer = MKPolygonRenderer(polygon: polygon)
            let mapPoint = MKMapPoint(location)
            let viewPoint = renderer.point(for: mapPoint)
            return renderer.path.contains(viewPoint)
        })
        recreatePrevSelectedPolygon()
    }
    
    private func recreatePrevSelectedPolygon() {
        guard let selectedPolygon = selectedPolygon else {
            return
        }

        mapView.removeOverlay(selectedPolygon)
        mapView.addOverlay(selectedPolygon)
    }
    
    
    
}
