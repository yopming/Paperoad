//
//  PaperCategorizer.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import Foundation
import RealmSwift

protocol PaperCategorizer: Object {
    var _partition: String? {get set}
    var count: Int {get set}
    var name: String {get set}
    init(name: String)
}

class IDObject: Object {
    @objc dynamic var _id: ObjectId
    
    override init() {
        self._id = ObjectId.generate()
    }
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    override class func shouldIncludeInDefaultSchema() -> Bool {
        self != IDObject.self
    }
}

