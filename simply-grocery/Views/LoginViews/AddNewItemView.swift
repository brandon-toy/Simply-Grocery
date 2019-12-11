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
    var body: some View {
      Button(action: {self.addButton.toggle()}) {
        Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
      AddNewItemView(addButton: .constant(true))
    }
}
