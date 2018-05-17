//
//  EmailValidator.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright © 2018 pecherukin. All rights reserved.
//

import Foundation

class EmailValidator {
    class func validate(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
