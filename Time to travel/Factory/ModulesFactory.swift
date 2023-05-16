import UIKit

protocol FactoryProtocol {
    func createFlightsModule(coordinator: CoordinatorProtocol) -> UIViewController
    func createDetailModule(model: FlightModel) -> UIViewController
}

class ModulesFactory: FactoryProtocol {
    
    private let networkManager: NetworkProtocol
    private let dataBaseManager: DataBaseProtocol
    
    init(networkManager: NetworkProtocol, dataBaseManager: DataBaseProtocol) {
        self.networkManager = networkManager
        self.dataBaseManager = dataBaseManager
    }
    
    func createFlightsModule(coordinator: CoordinatorProtocol) -> UIViewController {
        let view = FlightsViewController()
        let presenter = FlightsPresenter(networkManager: networkManager, databaseManager: dataBaseManager, coordinator: coordinator)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(model: FlightModel) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(model: model, dataBaseManager: dataBaseManager)
        view.presenter = presenter
        return view
    }
}
