//
//  FireStoreService.swift
//  FirebaseProject
//
//  Created by EricM on 11/18/19.
//  Copyright © 2019 EricM. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    private init () {}
    
    static let manager = FirestoreService()
    private let database = Firestore.firestore()
    
    
    func createAppUser(user: AppUser, completion: @escaping (Result<Void, Error>) -> Void) {
        database.collection("users").document(user.uid).setData(user.fieldsDict) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
        
    }
    
 
    func createPost(post: Post, completion: @escaping (Result<Void,Error>)-> Void){
        database.collection("posts").document(post.id.uuidString).setData(post.fieldsDict) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    
    func getPosts(completion: @escaping (Result<[Post], Error>)-> Void) {
        database.collection("posts").getDocuments { (snaphot, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let posts = snaphot?.documents.compactMap({ (snapshot) -> Post? in
                    let postID = snapshot.documentID
                    guard let postUID = UUID(uuidString: postID) else {return nil}
                    return Post(from: snapshot.data(), id: postUID)
                })
                
                completion(.success(posts ?? []))
            }
        }
    }
    
    
}
