//
//  MapInteractor.swift
//  WaadsuTask
//
//  Created by Danil Kovalev on 11.07.2022.
//

import Foundation

class MapInteractor {

    var presenter: MapPresenter?
    
    func didLoad() {
        NetowrkRequest(endpoint: .russiaGeoJson).execute { (data: GeoData?) in
            let value = data?.features.first?.geometry.coordinates ?? []
            let converted = value.flatMap { $0 }
            let result = converted.convertToCoordinates()
            let sum = self.calculateSumOfBorders(converted)
            self.presenter?.sumOfBordersFetched(sum: sum)
            for element in result {
                let edited = element.filter { $0.longitude < 180 }
                self.presenter?.coordinatesFetched(edited)
            }
        }
    }
    
    // MARK: - Сумма границ в км
    func calculateSumOfBorders(_ converted: [[[Double]]]) -> Int {
        var lastCoordinates: [Double] = []
        let sum = converted.reduce(0) { partialResult, regions in
            return regions.reduce(0) { partialResult2, coordinates in
                if lastCoordinates.isEmpty {
                    lastCoordinates = coordinates
                    return 0
                } else {
                    defer {
                        lastCoordinates = coordinates
                    }
                    return Int(coordinates.convertToCoordinates().toLocation().distance(from: lastCoordinates.convertToCoordinates().toLocation())) + partialResult2
                }
            } + partialResult
        }
        return sum/1000
    }
}


            
