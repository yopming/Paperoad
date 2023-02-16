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
        case missingPaperGroupKey // <paperId, groupId> key is paperId
        
        case duplicatedGroupName
        
        var errorDescription: String? {
            switch self {
            case .missingGroupName:
                return "Please provide a name for the group."
            case .missingPaperTitle:
                return "Please provide a title for the paper."
            case .missingPaperGroupKey:
                return "Please provide paperId for a <Paper, Group> pair."
                
            case .duplicatedGroupName:
                return "Group name exists already."
            }
        }
    }
}
