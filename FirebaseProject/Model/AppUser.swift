//
//  AppUser.swift
//  FirebaseProject
//
//  Created by EricM on 11/19/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import FirebaseAuth

struct AppUser {
    //let name: String?
    let email: String?
    let uid: String
    let userName: String?
    
    
    init(from user: User) {
        self.userName = user.displayName
        self.email = user.email
        self.uid = user.uid
        
    }
    
    var fieldsDict: [String: Any] {
        return [
            "userName": self.userName ?? "",
            "email": self.email ?? ""
            ]
    }
    
    
}
