//
//  MapPresenter.swift
//  WaadsuTask
//
//  Created by Danil Kovalev on 11.07.2022.
//

import Foundation
import MapKit

class MapPresenter {
    var view: MapViewController?
    private var isFirstPolygonAdded = false
    
    func coordinatesFetched(_ coordinates: [CLLocationCoordinate2D]) {
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
        view?.add(polygon: polygon)
        
        if !isFirstPolygonAdded {
            view?.showMapView()
            isFirstPolygonAdded = true
        }
    }
    
    func sumOfBordersFetched(sum: Int) {
        view?.updateInfoView(by: "\(sum) км")
    }
}
