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
  
  var body: some View {
    return Group {
      if loginButton {
        GroceryListCheck().navigationBarBackButtonHidden(true)
      } else {
        LoginPage(loginButton: $loginButton)
      }
    }
  }
}



struct LoginPage: View {
  @State private var name: String = ""
  @State private var email: String = ""
  @State private var password: String = ""
  @Binding var loginButton: Bool
  
  var body: some View {
//  NavigationView {
    VStack(spacing:20) {
        VStack {
          TextField("Email: ", text: $email)
            .font(.caption)
          Divider()
        }
        VStack {
          SecureField("Password: ",text: $password)
            .font(.caption)
          Divider()
        }
        Button(action: signIn) {
            Text("Login")
        }
//        NavigationLink(destination: GroceryListView(), isActive: self.$loginButton) {
//              Text("")
//        }.hidden()
      }
//      }.navigationBarBackButtonHidden(false)
  }
  func signIn() {
    Auth.auth().signIn(withEmail: email, password: password) {
      (result, error) in
      
      if error != nil {
        // cant sign in
        print(error!)
        // didnt sign in
        print(userSettings().getLogin())
      } else {
        // signed in
        print("signing in")
        self.loginButton = true
        userSettings().setLogin(val: true)
        userSettings().setEmail(email: self.email)
        userSettings().setName(name: self.name)
      }
    }
  }
}


struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
