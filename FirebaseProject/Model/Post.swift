//
//  Post.swift
//  FirebaseProject
//
//  Created by EricM on 11/19/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Post {
    let title: String
    let body: String
    let image: Data
    let id: UUID
    let userUID: String

    init(title: String, body: String, image: Data, userUID: String) {
        self.body = body
        self.title = title
        self.image = image
        self.userUID = userUID
        self.id = UUID()
    }

    init?(from dict: [String:Any], id: UUID){
        guard let title = dict["title"] as? String , let body = dict["body"] as? String , let image = dict["image"] as? Data , let userUID = dict["userUID"] as? String else {
            return nil
        }
        self.title = title
        self.body = body
        self.image = image
        self.userUID = userUID
        self.id = id
    }

    var fieldsDict: [String: Any]{
        return [
            "title": self.title, "body": self.body, "image": self.image , "userUID": self.userUID ]
    }
}


//struct Post {
//    let title: String
//    let body: String
//    let id: String
//    let creatorID: String
//    let dateCreated: Date?
//
//    init(title: String, body: String, creatorID: String, dateCreated: Date? = nil) {
//        self.title = title
//        self.body = body
//        self.creatorID = creatorID
//        self.id = UUID().description
//        self.dateCreated = dateCreated
//    }
//
//    init?(from dict: [String: Any], id: String) {
//        guard let title = dict["title"] as? String,
//            let body = dict["body"] as? String,
//            let userID = dict["creatorID"] as? String,
//            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
//
//        self.title = title
//        self.body = body
//        self.creatorID = userID
//        self.id = id
//        self.dateCreated = dateCreated
//    }
//
//    var fieldsDict: [String: Any] {
//        return [
//            "title": self.title,
//            "body": self.body,
//            "creatorID": self.creatorID
//        ]
//    }
//}
