//
//  GroceryListView.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-05.
//  Copyright © 2019 Brandon Toy. All rights reserved.

import SwiftUI
import Firebase
import MapKit

/**
 * Call this struct to autologin if user already logged in, in the past
 * @State signInSuccess: checks if user is logged in the past used for signing out also
 */
struct GroceryListCheck: View {
  @State var signInSuccess: Bool = userSettings().loggedIn
  @State private var settingsClick: Bool = false
  @State private var showAlert: Bool = false
  @EnvironmentObject var user: userSettings
  var body: some View {
    return Group {
      if signInSuccess {
        GroceryListView(signInSuccess: $signInSuccess, settingsClick: $settingsClick)
          .navigationBarTitle("Simply Grocery")
          .navigationBarHidden(false)
          .environmentObject(user)
      } else {
        WelcomeView()
          .navigationBarHidden(true)
      }
    }
  }
}

/**
 * Grocery list main view
 * @Binding signInSuccess: for logging out/in
 * @State addButton: For bringing up the sheet when pressing the "pencil" icon
 * @State user: user settings that is used to save and append the item to an array to use for the to get list
 */
struct GroceryListView: View {
  @Binding var signInSuccess: Bool
  @State var addButton: Bool = false
  @Binding var settingsClick: Bool
  @EnvironmentObject var user: userSettings
  
  /**
   * if scroll up -> refresh and sync to database
   * grab user inputs and put them in an array
   */
    var body: some View {
      ZStack {
       GeometryReader { geometry in
        TabView {
          ToDoListView(user: self.user)
            .tabItem {
              Image(systemName: "list.bullet")
              Text("List")
            }.environmentObject(self.user)
          ZStack {
            FindNearestView()
            VStack(alignment:.trailing) {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                      FindNearestView().searchForGroceryStores()
                    }) {
                        HStack {
                          Image(systemName: "arrow.clockwise")
                            .padding(.bottom, 2)
                        }
                        .padding()
                            .background(Color.black)
                            .mask(Circle())
                    }.frame(width: 60, height: 60)
                }
            }
          }.tabItem {
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
        
        
      }.onAppear(perform: {
        self.user.updateFields()  // update fields for saving past login
        print(self.user.email)
        let db = database(user: self.user)
        db.getDbGroceryList()
      })
        .navigationBarItems(trailing: Button(action: {self.settingsClick = true}) {
          Text("Sign Out")
            .alert(isPresented: $settingsClick) {
              Alert(title: Text("Sign Out"), message: Text("Are you sure?"), primaryButton: .default(Text("Sign out"), action: signOut), secondaryButton: .cancel())
          }
        })
        .sheet(isPresented: $addButton, content: {
          AddNewItemView(addButton: self.$addButton).environmentObject(self.user)
      })
      .font(.headline)
      .navigationBarHidden(false)
  }
  
  func addPress() {
    self.addButton.toggle()
  }
  
  func signOut() {
    do {
      print("Signing out")
      try Auth.auth().signOut()
      user.setLogin(val: false)
      self.signInSuccess = false
      print("this is usersettings: " , user.loggedIn)
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
