//
//  NetworkManager.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 12.05.2023.
//

import Foundation

protocol NetworkProtocol {
    func task(completion: @escaping (Result<[Flight], Error>) -> Void)
}

final class NetworkManager: NetworkProtocol {
    
    private let session = URLSession.shared
    
    //Собирает URL
    private func url() -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "vmeste.wildberries.ru"
        components.path = "/api/avia-service/twirp/aviaapijsonrpcv1.WebAviaService/GetCheap"
        return components.url!
    }
    
    //Создает URLRequest
    private func request() -> URLRequest {
        let payload = ["startLocationCode": "LED"]
        let jsonData = try? JSONSerialization.data(withJSONObject: payload)
        
        var request = URLRequest(url: url())
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json, text/plain, */*", forHTTPHeaderField: "Accept")
        return request
    }
    
    //Запрос на сервер
    func task(completion: @escaping (Result<[Flight], Error>) -> Void) {
        let request = request()
        let task = session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            // Обработка данных
            guard let data else { return }
            let json = try? JSONDecoder().decode(Flights.self, from: data)
            guard let json else { return }
            completion(.success(json.flights))
            
        }
        task.resume()
    }
}
