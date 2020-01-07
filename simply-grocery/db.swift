//
//  db.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-12.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI
import Firebase

class database {
  var uid: String = ""
  var email: String = ""
  @Published var user: userSettings
  
  init(user: userSettings) {
    self.uid = ""
    self.user = user
    self.email = user.email
  }
  
  /**
   * Update a single row and only the different ones in the array
   * @num: number of row to be updated
   * @dbRow: Array to be updated
   */
  func pushSingleDBRow(num: Int, dbRow: [String: Any]) {
    let user = Auth.auth().currentUser
    if user != nil {
      self.uid = user!.uid
      self.email = user!.email!
      self.addNewSingleGroceryRow(num: num ,dbRow: dbRow)
    }
  }
  
  func getDbGroceryList() {
    self.offlineCacheInit()
    // get local cache
    Firestore.firestore().disableNetwork { (error) in
      self.getList()
    }
    
    print("checking online")
    Firestore.firestore().enableNetwork { (error) in
      self.getList()
    }
  }
  
  func deleteFromDb(item: String) {
    let db = Firestore.firestore()
    let userFields = db.collection("users").document(self.email)
    userFields.updateData([
        "groceryList": FieldValue.arrayRemove([item])
    ]) {
      err in
      if let err = err {
          print("Error deleting field: \(err)")
      } else {
          print("Field successfully deleted")
      }
    }
  }
  
  func pushDB() {
    let user = Auth.auth().currentUser
    if user != nil {
      self.uid = user!.uid
      self.email = user!.email!
      self.updateDB()
    }
  }
  
  private func addNewSingleGroceryRow(num: Int,dbRow: [String:Any]) {
    self.offlineCacheInit()
    let db = Firestore.firestore()
    let userInfo = db.collection("users").document(self.email)
    let numStr = "\(num)"
    userInfo.updateData([
      numStr: dbRow
    ])
    
  }
  
  private func updateDB() {
    self.offlineCacheInit()
    let db = Firestore.firestore()
    print("yeet")
    Firestore.firestore().enableNetwork { (error) in
      db.collection("users").document(self.email).updateData([
        "groceryList": FieldValue.arrayUnion(self.user.list)
      ]) { err in
          if let err = err {
              print("Error writing document: \(err)")
          } else {
              print("Document successfully written!")
          }
      }
    }
  }
  
  private func getList() {
    let db = Firestore.firestore()
    print("email: '\(self.email)'")
    let docRef = db.collection("users").document(self.email)
    docRef.getDocument { (document, error) in
      if let document = document, document.exists {
        let groceryList = document.data()!["groceryList"] as! [String]
        self.user.list = groceryList
        print(self.user.list)
      } else {
        print("error retrieving document (empty)")
      }
    }
  }
  
  public func offlineCacheInit() {
    let settings = Firestore.firestore().settings
    settings.isPersistenceEnabled = true
    settings.cacheSizeBytes = FirestoreCacheSizeUnlimited
    Firestore.firestore().settings = settings
  }
  
}
