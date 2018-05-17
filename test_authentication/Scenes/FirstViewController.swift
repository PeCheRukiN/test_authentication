//
//  FirstViewController.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright © 2018 pecherukin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var authButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authButton.layer.cornerRadius = authButton.bounds.height/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
