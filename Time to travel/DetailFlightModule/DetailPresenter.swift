//
//  DetailPresenter.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 15.05.2023.
//

import Foundation

protocol DetailPresenterProtocol {
    func getModel() -> FlightModel
    func saveFlight()
    func deleteFlight()
}

class DetailPresenter: DetailPresenterProtocol {
    
    private let dataBaseManager: DataBaseProtocol
    
    private var model: FlightModel
    
    init(model: FlightModel, dataBaseManager: DataBaseProtocol) {
        self.model = model
        self.dataBaseManager = dataBaseManager
    }
    
    //Передает модель
    func getModel() -> FlightModel {
        model
    }
    
    //Сохраняет модель в БД
    func saveFlight() {
        dataBaseManager.saveLikedFlight(token: model.searchToken)
        model.isLiked = true
    }
    
    //Удаляет модель из БД
    func deleteFlight() {
        dataBaseManager.deleteFlight(token: model.searchToken)
        model.isLiked = false
    }
    
}
