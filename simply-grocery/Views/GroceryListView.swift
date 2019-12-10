//
//  GroceryListView.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-05.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI
import Firebase

struct GroceryListCheck: View {
  @State var signInSuccess: Bool = userSettings().getLogin()
  var body: some View {
    return Group {
      if signInSuccess {
        GroceryListView(signInSuccess: $signInSuccess)
          .navigationBarHidden(true)
          .navigationBarTitle("Hidden Title")
      } else {
        WelcomeView()
          .navigationBarHidden(true)
          .navigationBarTitle("Hidden Title")
      }
    }
  }
}

struct GroceryListView: View {
  @Binding var signInSuccess: Bool
  @State var email: String = ""
  
    var body: some View {
      VStack {
        Text("email: "+email)
        Text("hello world")
        Button(action: signOut) {
          Text("Sign out")
        }
      }.onAppear {self.storeEmail()}
    }
  
    func storeEmail() {
      let user = Auth.auth().currentUser
      if let user = user {
        // The user's ID, unique to the Firebase project.
        // Do NOT use this value to authenticate with your backend server,
        // if you have one. Use getTokenWithCompletion:completion: instead.
        self.email = user.email!
      }
    }
  
    func signOut() {
      do {
        print("Signing out")
        try Auth.auth().signOut()
        userSettings().setLogin(val: false)
        self.signInSuccess = false
        print("this is usersettings: " , userSettings().getLogin())
      } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
    }
  }
}

//struct GroceryListView_Previews: PreviewProvider {
//    static var previews: some View {
//      var yeet = true
//        GroceryListView(signInSuccess: Binding(true))
//    }
//}
