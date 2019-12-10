//
//  File.swift
//  Simply Grocery
//
//  Created by Brandon Toy on 2019-12-05.
//  Copyright © 2019 Brandon Toy. All rights reserved.
//

import Foundation

func verifyEmail(user: String) -> Bool {
  let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
  return emailPred.evaluate(with: user)
}
