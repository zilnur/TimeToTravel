import UIKit

protocol CoordinatorProtocol {
    func start(window: UIWindow?)
    func pushToDetailView(model: FlightModel)
}

class Coordinator: CoordinatorProtocol {
    
    private let factory: FactoryProtocol
    
    init(factory: FactoryProtocol) {
        self.factory = factory
    }
    
    private let navigationController = UINavigationController()
    
    //Устанавливает root экран приложения.
    func start(window: UIWindow?) {
        let view = factory.createFlightsModule(coordinator: self)
        navigationController.setViewControllers([view], animated: false)
        window?.rootViewController = self.navigationController
    }
    
    //Переход на следующий экран
    func pushToDetailView(model: FlightModel) {
        let view = factory.createDetailModule(model: model)
        navigationController.pushViewController(view, animated: true)
    }
    
}
