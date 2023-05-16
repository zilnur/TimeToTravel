//
//  FlightsViewModel.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//

import Foundation

protocol FlightsPresenterProtocol {
    func setModel(completion: @escaping (Error?) -> Void)
    func getModel() -> [FlightModel]
    func goToNextView(index: IndexPath)
    func updateFlights()
}

class FlightsPresenter {
    
    private var model: [FlightModel] = []
    private let coordinator: CoordinatorProtocol
    private let networkManager: NetworkProtocol
    private let databaseManager: DataBaseProtocol
    
    init(networkManager: NetworkProtocol, databaseManager: DataBaseProtocol, coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        self.databaseManager = databaseManager
    }
    
    //Заполняет модель
    private func createFlight(isLiked: Bool, flight: Flight) {
        let flight = FlightModel(searchToken: flight.searchToken,
                                 isLiked: isLiked,
                                 startDate: flight.startDate,
                                 endDate: flight.endDate,
                                 startCity: flight.startCity,
                                 endCity: flight.endCity,
                                 price: flight.price)
        model.append(flight)
    }
    
    
}

extension FlightsPresenter: FlightsPresenterProtocol {
    
    //Получение и обработка данных из сети
    func setModel(completion: @escaping (Error?) -> Void) {
        let likedFlights = databaseManager.getLikedFlights()
        networkManager.task { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let flights):
                flights.forEach { flight in
                    if likedFlights.contains(where: {$0.searchToken == flight.searchToken}) {
                        self.createFlight(isLiked: true, flight: flight)
                    } else {
                        self.createFlight(isLiked: false, flight: flight)
                    }
                }
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    //Обновление модели
    func updateFlights() {
        model.forEach { flight in
            if databaseManager.getLikedFlights().contains(where: {$0.searchToken == flight.searchToken}) {
                if let index = model.firstIndex(of: flight) {
                    model[index].isLiked = true
                }
            } else {
                if let index = model.firstIndex(of: flight) {
                    model[index].isLiked = false
                }
            }
        }
    }
    
    func getModel() -> [FlightModel] {
        model
    }
    
    func goToNextView(index: IndexPath) {
        coordinator.pushToDetailView(model: model[index.row])
    }
    
}
