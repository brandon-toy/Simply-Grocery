//
//  GroceryListView.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-05.
//  Copyright © 2019 Brandon Toy. All rights reserved.
// credits https://www.flaticon.com/authors/smashicons

import SwiftUI
import Firebase

struct GroceryListCheck: View {
  @State var signInSuccess: Bool = userSettings().getLogin()
  var body: some View {
    return Group {
      if signInSuccess {
        GroceryListView(signInSuccess: $signInSuccess)
          .navigationBarTitle("Simply Grocery")
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
  @State var addButton: Bool = false
  
  /**
   * if scroll up -> refresh and sync to database
   * grab user inputs and put them in an array
   */
    var body: some View {
      ZStack {
       GeometryReader { geometry in
        TabView {
          ToDoListView()
            .tabItem {
              Image(systemName: "list.bullet")
              Text("List")
            }
//          ToDoListView()
//            .tabItem {
//              Button(action: self.addPress) {
//                  Text("add")
//                }
//            }
          Button(action: self.signOut) {
            Text("Sign out")
          }
            .tabItem {
              Image(systemName: "location")
              Text("Locater")
            }
        }
          Image(systemName: "pencil.and.outline")
           .resizable()
           .frame(width: 40, height: 40)
           .offset(x: geometry.size.width / 2 - 20, y: geometry.size.height - 70)
           .onTapGesture {
            self.addButton.toggle()
          }
        }
      }
        .sheet(isPresented: $addButton, content: {
          AddNewItemView(addButton: self.$addButton)
        })
        .font(.headline)
        .navigationBarHidden(false)
        .navigationBarTitle("Grocery List")
      }
//  .onAppear {self.storeEmail()}
  
//    func storeEmail() {
//      let user = Auth.auth().currentUser
//      if let user = user {
//        // The user's ID, unique to the Firebase project.
//        // Do NOT use this value to authenticate with your backend server,
//        // if you have one. Use getTokenWithCompletion:completion: instead.
//      }
//    }
  
    func addPress() {
      self.addButton.toggle()
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

struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        GroceryListCheck(signInSuccess: true)
          .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
          .previewDisplayName("iPhone 11 Pro")
          .environment(\.colorScheme, .dark)
        GroceryListCheck(signInSuccess: true)
          .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
          .previewDisplayName("iPhone 11 Pro Max")
      }
  }
}
