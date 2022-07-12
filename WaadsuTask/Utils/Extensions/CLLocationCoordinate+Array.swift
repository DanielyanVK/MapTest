//
//  CLLocationCoordinate+Array.swift
//  WaadsuTask
//
//  Created by Danil Kovalev on 11.07.2022.
//

import Foundation
import CoreLocation

extension Array where Element == [[Double]] {
    func convertToCoordinates() -> [[CLLocationCoordinate2D]] {
        map { array in
            return array.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
        }
    }
}

extension Array where Element == Double {
    func convertToCoordinates() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self[1], longitude: self[0])
    }
}

extension CLLocationCoordinate2D {
    func toLocation() -> CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
