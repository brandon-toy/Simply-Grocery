//
//  WelcomeView.swift
//  simply-grocery
//
//  Created by Brandon Toy on 2019-12-02.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
  var body: some View {
    return Group {
      if userSettings().getLogin() {
        GroceryListCheck()
      } else {
//        WelcomeViewPage()
      }
    }
  }
}

struct WelcomeViewPage: View {
    var body: some View {
        
      NavigationView {
        VStack() {
          Title()
          Spacer()
          VStack(spacing: 50) {
              VStack() {
                  Image("grocery")
                    .resizable()
                    .frame(width: 50, height: 50)
                  Text("Groceries all in one").font(.body)
                  Text("place").font(.body)
                }
                VStack {
                  Image("map")
                    .resizable()
                    .frame(width: 35, height: 35)
                  Text("Find all grocery").font(.body)
                  Text("stores nearby").font(.body)
                }
            }
            Spacer()

            VStack {
                NavigationLink(destination: SignUpPage()) {
                    Text("Sign Up")
                      .padding(.horizontal, 50)
                      .padding(.vertical, 10)
                      .foregroundColor(Color("inverted"))
              }.overlay(
                  RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("inverted"), lineWidth: 1)
              )
              NavigationLink(destination: Login()) {
                Text("Login")
                .padding()
                .font(.caption)
              }
            }
            Spacer()
          }
        .navigationBarHidden(true)
      }
    }
}

struct Title: View {
  var body: some View {
    VStack(alignment:.leading){
      Text("Simply").font(.largeTitle).bold()
      Text("Grocery").font(.largeTitle).bold()
      Text("it just works.").font(.subheadline)
    }
  }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
      Group {
         WelcomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .previewDisplayName("iPhone 11 Pro")
         WelcomeView()
            .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
            .previewDisplayName("iPhone XS Max")
            .environment(\.colorScheme, .dark)
      }
    }
}
