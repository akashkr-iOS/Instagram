//
//  DatabaseManager.swift
//  Instagram
//
//  Created by akash on 26/12/22.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    ///Checks whether the username and email is available
      ///  - Parameters
      /// - email: String representing email
     /// - username: String representing username
  
    public func canCreateUsername(email: String, username: String, completion: @escaping (Bool) -> Void){
        completion(true)
    }
    
    ///Inserts new user data to database

    public func insertNewUser(email: String, username:String, completion: @escaping (Bool) -> Void){
        database.child(email.safeDatabaseKey()).setValue(["username":username]) { error, _ in
            if error == nil {
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
    
}
