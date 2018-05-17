//
//  RegistrationController.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright © 2018 pecherukin. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = registerButton.bounds.height/2
    }
}
