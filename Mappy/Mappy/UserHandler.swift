//
//  UserHandler.swift
//  Mappy
//
//  Created by gabriel brickman hildingsson on 2019-11-25.
//  Copyright © 2019 Emil Persson. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class UserHandler {
    static let instance = UserHandler()
    var user = Auth.auth().currentUser
    //MARK: CREATE USER
    func createUser(email: String, password: String,firstName: String,lastName: String , _ callback: ((Error?) -> ())? = nil){
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let e = error{
                callback?(e)
                return
            } else {
                if let user = Auth.auth().currentUser?.createProfileChangeRequest() {
                    user.displayName = "\(firstName) \(lastName)"
                }
            }
            callback?(nil)
        }
    }
    
    //MARK: SIGN IN USER
    func login(withEmail email: String, password: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let e = error{
                self.reloadUser()
                callback?(e)
                return
            }
            self.reloadUser()
            callback?(nil)
        }
    }
    
    //MARK: SIGN OUT
    func signOut() -> Bool{
        do{
            try Auth.auth().signOut()
            self.reloadUser()
            return true
        }catch{
            return false
        }
    }
    
    //MARK: REALOAD USER
    //this needs to be done to update to get the latest user information ex profilepic,name,email verification
    func reloadUser(_ callback: ((Error?) -> ())? = nil){
        print("reload")
        Auth.auth().currentUser?.reload(completion: { (error) in
            self.user = Auth.auth().currentUser
            callback?(error)
        })
        self.user = Auth.auth().currentUser
    }
    
    //MARK: RESET PASSWORD
    func sendPasswordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            callback?(error)
        }
    }
}
