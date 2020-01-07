//
//  login.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-07.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import Foundation
import SwiftUI

class userSettings : ObservableObject {
  
  var loggedIn : Bool
  var name : String = ""
  var email : String = ""
  var uid : String = ""
  @Published var list: [String] = []
  
  init() {
    self.loggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
  }
  
  func setLogin(val: Bool) {
    UserDefaults.standard.set(val, forKey: "isLoggedIn")
    UserDefaults.standard.synchronize()
    self.loggedIn = val
  }
  
  func setName(name: String) {
    UserDefaults.standard.set(name, forKey: "name")
    UserDefaults.standard.synchronize()
  }
  
  func setEmail(email: String) {
    UserDefaults.standard.set(email, forKey: "email")
    UserDefaults.standard.synchronize()
  }

  
  func setUID(uid: String) {
    UserDefaults.standard.set(uid, forKey: "uid")
    UserDefaults.standard.synchronize()
  }
  
  func getUID() -> String {
    return self.uid
  }
  
  func addToArray(item: String) {
    self.list.append(item)
    print(self.list)
  }
  
  func updateFields() {
    self.name = UserDefaults.standard.string(forKey: "name")!
    self.email = UserDefaults.standard.string(forKey: "email")!
  }
  
  func setUserDetails(name: String, email: String, login: Bool) {
    self.setLogin(val: login)
    self.setEmail(email: email)
    self.setName(name: name)
  }
  
}
