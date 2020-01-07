//
//  AddNewItemView.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-10.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI
import Firebase

struct AddNewItemView: View {
  @Binding var addButton: Bool
  @EnvironmentObject var user: userSettings
  @State var item: String = ""
  var body: some View {
    VStack {
      Spacer().frame(width: 10, height: 20)
      HStack {
        Image(systemName: "xmark")
          .padding(.horizontal,20)
          .onTapGesture {
            self.addButton.toggle()
          }
        Spacer()
      }
      Spacer().frame(width: 10, height: 100)
      TextField("Item here", text: $item)
        .font(.largeTitle)
        .padding(.all, 20)
      Button(action: addItem) {
        Text("Submit")
      }
      Spacer()
    }.onAppear(perform: {print(self.user.list)})
  }
  func addItem() {
    self.user.addToArray(item: self.item)
    let db = database(user: self.user) // initialize database
    db.user = self.user // set user
    db.pushDB()
    print("Added to array")
    self.addButton.toggle()
  }
}
