//
//  Date.swift
//  Paperoad
//
//  Created by Tieming on 2/2/23.
//

import Foundation

func DateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/YY"
    return dateFormatter.string(from: date)
}

