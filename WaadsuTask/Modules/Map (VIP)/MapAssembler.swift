//
//  MapAssembler.swift
//  WaadsuTask
//
//  Created by Danil Kovalev on 11.07.2022.
//

import Foundation

struct MapAssembler {
    func assembly() -> MapViewController {
        let view = MapViewController()
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
