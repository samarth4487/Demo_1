//
//  User.swift
//  Sample
//
//  Created by Samarth Paboowal on 31/01/18.
//  Copyright © 2018 Samarth Paboowal. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class User: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    
    func addUser(name: String, email: String, password: String) -> Bool {
        
        if !isUserRegisteredWith(email: email) {
            let realm = try! Realm()
            self.name = name
            self.email = email
            self.password = password
            
            try! realm.write {
                realm.add(self)
            }
            
            return true
        }
        
        return false
    }
    
    static func getUsersCount() -> Int {
        
        let realm = try! Realm()
        let users = realm.objects(User.self)
        
        return users.count
    }
    
    func isUserRegisteredWith(email: String) -> Bool {
        
        let realm = try! Realm()
        let user = realm.objects(User.self).filter("email == %@", email)
        if user.count == 1 {
            return true
        }
        
        return false
    }
}


class LoggedUser {
    
    static func username() -> String? {
        if let name = UserDefaults.standard.value(forKey: "NAME") as? String {
            return name
        }
        return ""
    }
    
    static func userEmail() -> String? {
        if let email = UserDefaults.standard.value(forKey: "EMAIL") as? String {
            return email
        }
        return ""
    }
    
    static func isLoggedIn() -> Bool {
        let bool = UserDefaults.standard.bool(forKey: "LOGGED_IN")
        return bool
    }
    
    static func saveLoggedInUser(name: String, email: String) {
        UserDefaults.standard.set(name, forKey: "NAME")
        UserDefaults.standard.set(email, forKey: "EMAIL")
    }
    
    static func clearUserData() {
        UserDefaults.standard.set(nil, forKey: "NAME")
        UserDefaults.standard.set(nil, forKey: "EMAIL")
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
    }
}
