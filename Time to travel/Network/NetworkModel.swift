//
//  NetworkModel.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 13.05.2023.
//

import Foundation

struct Flights: Decodable {
    let flights: [Flight]
}

struct Flight: Decodable {
    let searchToken: String
    let startDate: String
    let endDate: String
    let startCity: String
    let endCity: String
    let price: Int32
}
