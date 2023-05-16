//
//  lightModel.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 15.05.2023.
//

import Foundation

struct FlightModel: Equatable {
    let searchToken: String
    var isLiked: Bool
    let startDate: String
    let endDate: String
    let startCity: String
    let endCity: String
    let price: Int32
}
