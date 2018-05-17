//
//  AuthenticationModels.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright (c) 2018 pecherukin. All rights reserved.
//

import UIKit
import CoreLocation

enum Authentication {
    struct Request {
        var email: String
        var password: String
        var location: CLLocationCoordinate2D?
    }
    struct Response {
        var temperature: String
        var humidity: Int
        var pressure: Int
    }
    struct ViewModel {
        
    }
}
