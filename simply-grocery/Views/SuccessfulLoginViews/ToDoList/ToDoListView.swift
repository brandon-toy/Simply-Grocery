//
//  ToDoListView.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-10.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI
import Firebase

struct groceryList {
  let item: String
}

struct ToDoListView: View {
  @ObservedObject var user: userSettings

  var body: some View {
    List {
      ForEach(self.user.list, id: \.self) { grocery in
        HStack {
          Text(grocery)
        }
      }.onDelete(perform: deleteItems)
    }.onAppear(perform: {print(self.user.list)})
  }
  private func deleteItems(at offsets: IndexSet) {
    guard let index = Array(offsets).first else { return }
    let removed = self.user.list.remove(at: index)
    // delete from database
    let dbFirebase = database(user: self.user)
    dbFirebase.deleteFromDb(item: removed)
  }
}

//
//struct ToDoListView_Previews: PreviewProvider {
//    static var previews: some View {
//      ToDoListView().
//    }
//}
