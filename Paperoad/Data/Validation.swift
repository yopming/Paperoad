//
//  Validation.swift
//  Paperoad
//
//  Created by Tieming Geng on 2/7/23.
//

import Foundation

extension AppDatabase {
    enum ValidationError: LocalizedError {
        case missingGroupName
        case missingPaperTitle
        
        var errorDescription: String? {
            switch self {
            case .missingGroupName:
                return "Please provide a name for the group."
            case .missingPaperTitle:
                return "Please provide a title for the paper."
            }
        }
    }
}
