//
//  login.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-07.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import Foundation
import SwiftUI

class userSettings : ObservableObject{
  
  var loggedIn : Bool
  var name : String = ""
  var email : String = ""
  var uid : String = ""
  
  init() {
    self.loggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
  }
  
  func getLogin() -> Bool {
    return self.loggedIn
  }
  
  func setLogin(val: Bool) {
    UserDefaults.standard.set(val, forKey: "isLoggedIn")
    UserDefaults.standard.synchronize()
    self.loggedIn = self.getLogin()
  }
  
  func getName() -> String {
    return self.name
  }
  
  func setName(name: String) {
    self.name = name
  }
  
  func setEmail(email: String) {
    self.email = email
  }
  
  func getEmail() -> String {
    return self.email
  }
  
  func setUID(uid: String) {
    self.uid = uid
  }
  
  func getUID() -> String {
    return self.uid
  }
  
}
