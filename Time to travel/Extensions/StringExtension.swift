//
//  StringExtension.swift
//  Time to travel
//
//  Created by Ильнур Закиров on 14.05.2023.
//

import Foundation

extension String {
    
    //Переводит полученную с сервера дату в дату для UI
    func convertToDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ 'UTC'"
        guard let date = dateFormatter.date(from: self) else { return ""}
        dateFormatter.dateFormat = "EE, dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    //Переводит полученную с сервера дату во время для UI
    func convertToTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ 'UTC'"
        guard let date = dateFormatter.date(from: self) else { return ""}
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
