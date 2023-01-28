//
//  GroupModel.swift
//  Paperoad
//
//  Created by Tieming Geng on 1/28/23.
//

import RealmSwift
import Foundation

class GroupModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = ""
    @Persisted var desc: String?
    @Persisted var createTime = Date()
    @Persisted var updateTime = Date()
}
