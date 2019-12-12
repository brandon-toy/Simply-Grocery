//
//  AddNewItemView.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-10.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI

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
      }
    }
  func addItem() {
    let groceryItem = groceryList(item: self.item, isChecked: false, index: self.user.list.count)
    self.user.addToArray(item: groceryItem)
    // push to database???
    print(self.user.getArray())
    print("Added to array")
    self.addButton.toggle()
  }
}

//struct AddNewItemView_Previews: PreviewProvider {
//    static var previews: some View {
//      AddNewItemView(addButton: .constant(true)).environmentObject(userSettings)
//    }
//}
