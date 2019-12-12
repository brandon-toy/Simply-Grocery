//
//  ToDoListView.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-10.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI

struct groceryList {
  let item: String
  var isChecked: Bool
  var index: Int
}

struct ToDoListView: View {
  @ObservedObject var usertest: userSettings
  @ObservedObject var model  = MyModel()

  var body: some View {
    List {
      ForEach(self.usertest.list, id: \.item) { grocery in
        HStack {
          if grocery.isChecked {
            Image(systemName: "circle.fill")
              .onTapGesture {
                self.usertest.list[grocery.index].isChecked = false
            }
            Text(grocery.item)
            .strikethrough()
          } else {
            Image(systemName: "circle")
              .onTapGesture {
                self.usertest.list[grocery.index].isChecked = true
            }
            Text(grocery.item)
          }
        }
      }.onDelete(perform: deleteItems)
    }
  }
  private func deleteItems(at offsets: IndexSet) {
    self.usertest.list.remove(atOffsets: offsets)
    // sync to database?
    print(self.usertest.list)
  }
}
//
//struct ToDoListView_Previews: PreviewProvider {
//    static var previews: some View {
//      ToDoListView().
//    }
//}
