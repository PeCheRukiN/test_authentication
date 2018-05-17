//
//  AuthenticationWorker.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright (c) 2018 pecherukin. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class AuthenticationWorker: NSObject, CLLocationManagerDelegate {
    
    func validate(_ email: String, password: String) -> String? {
        guard EmailValidator.validate(email) else {
            return "Проверьте корректность введенного email адреса."
        }
        guard PasswordValidator.validate(password) else {
            return "Пароль должен быть минимум 6 символов, обязательно содержать минимум 1 строчную букву, 1 заглавную, и 1 цифру."
        }
        return nil
    }
    
    func getCurenntWheather(for lon: Double, lat: Double, _ completion: @escaping (Wheather) -> ()) {
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&APPID=93fefa4d6b24730c37c276526b175120"
        Alamofire.request(url, method: .get, headers: ["Content-Type": "application/json"]).responseJSON { (response) in
            if let data = response.data {
                do {
                    let wheather = try JSONDecoder().decode(Wheather.self, from: data)
                    completion(wheather)
                } catch {
                    print(error)
                }
            }
        }
    }
}
