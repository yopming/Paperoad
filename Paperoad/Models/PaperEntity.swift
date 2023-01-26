//
//  PaperEntity.swift
//  Paperoad
//
//  Created by Tieming on 1/25/23.
//

import Foundation
import RealmSwift

class PaperEntityIdObject: Object {
    @objc dynamic var id: ObjectId
    @objc dynamic var _id: ObjectId
    
    override init() {
        self.id = ObjectId.generate()
        self._id = self.id
    }
    
    override class func primaryKey() -> String? {
        return "_id"
    }
    
    override class func shouldIncludeInDefaultSchema() -> Bool {
        self != PaperEntityIdObject.self
    }
}

class PaperEntity: PaperEntityIdObject, ObjectKeyIdentifiable {
    @Persisted var _partition: String?
    @Persisted var addTime: Date
    @Persisted var title: String = ""
    @Persisted var authors: List<String>
    @Persisted var publication: String = ""
    @Persisted var pubTime: String = ""
    @Persisted var pubType: Int = 2 // 0: Journal, 1: Conference, 2: Others
    @Persisted var doi: String = ""
    @Persisted var arxiv: String = ""
    @Persisted var mainURL: String = ""
    @Persisted var supURLs: List<String>
    @Persisted var rating: Int = 0
    @Persisted var tags: List<PaperTag>
    @Persisted var folders: List<PaperFolder>
    @Persisted var flag: Bool = false
    @Persisted var note: String = ""
    
    convenience init(
        title: String?,
        authors: [String]?,
        publication: String?,
        pubTime: String?,
        pubType: Int?,
        doi: String?,
        arxiv: String?,
        mainURL: String?,
        supURLs: [String]?,
        rating: Int?,
        flag: Bool?
    ) {
        self.init()
        self.id = self._id
        self.addTime = Date()
        
        self.title = title ?? ""
        self.publication = publication ?? ""
        self.pubTime = pubTime ?? ""
        self.pubType = pubType ?? 2
        self.doi = doi ?? ""
        self.arxiv = arxiv ?? ""
        self.mainURL = mainURL ?? ""
        self.rating = rating ?? 0
        self.flag = flag ?? false
        authors?.forEach{author in
            self.authors.append(author)
        }
        supURLs?.forEach { supURL in
            self.supURLs.append(supURL)
        }
    }
}
