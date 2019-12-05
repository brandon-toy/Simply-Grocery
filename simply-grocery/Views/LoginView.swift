//
//  Login.swift
//  simply-grocery
//
//  Created by Brandon Toy on 2019-12-02.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import SwiftUI

struct Login: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: ")
                .font(.title)
            Text("Email Addres: ")
                .font(.title)
        }.navigationBarBackButtonHidden(true)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
