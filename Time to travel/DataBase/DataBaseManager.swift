import Foundation
import CoreData

protocol DataBaseProtocol {
    func saveLikedFlight(token: String)
    func getLikedFlights() -> [LikedFlight]
    func deleteFlight(token: String)
}

class DataBaseManager: DataBaseProtocol {
    
    private var container: NSPersistentContainer
    
    private lazy var viewContext = container.viewContext
    
    init() {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if error != nil {
                fatalError()
            }
        }
        self.container = container
    }
    
    //Сохранение понравившегося перелета (для сохранения состояния после перезагрузки приложения)
    func saveLikedFlight(token: String) {
        viewContext.perform {
            let flight = NSEntityDescription.insertNewObject(forEntityName: "LikedFlight", into: self.viewContext) as! LikedFlight
            flight.searchToken = token
            do {
                try self.viewContext.save()
            } catch {
                print(error)
            }
        }
        
    }
    
    //Получение всех понравившихся передетов
    func getLikedFlights() -> [LikedFlight] {
        var flights = [LikedFlight]()
        let request = LikedFlight.fetchRequest()
        do {
            let likedFlights = try viewContext.fetch(request)
            flights = likedFlights
        } catch {
            print(error)
        }
        return flights
    }
    
    //Удаления перелета из понравившихся
    func deleteFlight(token: String) {
        viewContext.perform { [weak self] in
            guard let self else { return }
            let request = LikedFlight.fetchRequest()
            do {
                var flights = try self.viewContext.fetch(request)
                guard let flight = flights.first(where: {$0.searchToken == token}) else { return }
                viewContext.delete(flight)
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
}
