//
//  AuthenticationInteractor.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright (c) 2018 pecherukin. All rights reserved.
//

import UIKit

protocol AuthenticationBusinessLogic {
    func logIn(_ request: Authentication.Request)
    func restorePassword()
}

class AuthenticationInteractor: AuthenticationBusinessLogic {
    var presenter: AuthenticationPresentationLogic?
    var worker: AuthenticationWorker?
    
    init() {
        worker = AuthenticationWorker()
    }
    
    // MARK: Do something
    
    func logIn(_ request: Authentication.Request) {
        worker = AuthenticationWorker()
        if let validationErrorDescription = worker?.validate(request.email, password: request.password) {
            presenter?.present(validationErrorDescription: validationErrorDescription)
        } else {
            if let location = request.location {
                worker?.getCurenntWheather(for: location.longitude, lat: location.latitude) { (wheather) in
                    let response = Authentication.Response(temperature: wheather.getTemperature(in: .Celsius), humidity: wheather.main.humidity, pressure: wheather.main.pressure).self
                    self.presenter?.presentFetchedWheather(response)
                }
            }
        }
    }
    
    func restorePassword() {
        presenter?.presentRestorePasswordAlert()
    }
}
