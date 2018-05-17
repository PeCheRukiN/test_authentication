//
//  PasswordValidator.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright © 2018 pecherukin. All rights reserved.
//

import Foundation

class PasswordValidator {
    class func validate(_ password: String) -> Bool {
        guard
            password.count > 5,
            password.rangeOfCharacter(from: .decimalDigits) != nil,
            password.rangeOfCharacter(from: .lowercaseLetters) != nil,
            password.rangeOfCharacter(from: .uppercaseLetters) != nil
            else { return false }
        return true
    }
}
