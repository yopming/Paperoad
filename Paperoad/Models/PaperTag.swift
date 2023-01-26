//
//  PaperTag.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import Foundation
import RealmSwift

class PaperTag: IDObject, ObjectKeyIdentifiable, PaperCategorizer {
    @Persisted var _partition: String?
    @Persisted var count: Int = 0
    @Persisted var name: String = ""
    
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
}
