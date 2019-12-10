//
//  Session.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-07.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase

class User {
    var uid: String
    var email: String
    var password: String?

    init(uid: String, email: String, password: String) {
        self.uid = uid
        self.email = email
        self.password = password
    }

}
