//
//  Login.swift
//  simply-grocery
//
//  Created by Brandon Toy on 2019-12-02.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI
import Firebase

struct Login: View {
  @State var loginButton: Bool = false
  @State var user: userSettings = userSettings()
  var body: some View {
    return Group {
      if loginButton {
        GroceryListCheck()
          .navigationBarBackButtonHidden(true)
          .environmentObject(user)
      } else {
        LoginPage(user: $user, loginButton: $loginButton)
      }
    }
  }
}



struct LoginPage: View {
  @State private var name: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var error: String = ""
  @Binding var user: userSettings
  @Binding var loginButton: Bool
  
  var body: some View {
    VStack(spacing:20) {
      Title()
      Spacer().frame(width:10, height:5)
      if error != "" {
        Text(error).font(.caption)
      }
      Spacer().frame(width:10, height:5)
      VStack(spacing: 1) {
        TextField("Email: ", text: $email)
          .font(.caption)
          .autocapitalization(.none)
        Divider()
      }
      VStack(spacing: 1) {
        SecureField("Password: ",text: $password)
          .font(.caption)
        Divider()
      }
      Button(action: signIn) {
          Text("Login")
      }
      Spacer().frame(width:10, height:250)
    }.padding(50)
  }
  func signIn() {
    Auth.auth().signIn(withEmail: email, password: password) {
      (result, error) in
      if error != nil {
        // cant sign in (wrong password, etc.)
        self.error = "Incorrect Password or Email"
      } else {
        // signed in
        print("Signing in")
        self.loginButton = true
        self.user.setUserDetails(name: self.name, email: self.email, login: true)
      }
    }
  }
}


//struct Login_Previews: PreviewProvider {
//    static var previews: some View {
//        Login()
//    }
//}
