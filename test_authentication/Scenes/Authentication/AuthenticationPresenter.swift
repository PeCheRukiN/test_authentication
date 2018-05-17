//
//  AuthenticationPresenter.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright (c) 2018 pecherukin. All rights reserved.
//

import UIKit

protocol AuthenticationPresentationLogic {
    func present(validationErrorDescription: String)
    func presentRestorePasswordAlert()
    func presentFetchedWheather(_ response: Authentication.Response)
}

class AuthenticationPresenter: AuthenticationPresentationLogic {
    weak var viewController: AuthenticationDisplayLogic?
    
    // MARK: Do something
    
    func present(validationErrorDescription: String) {
        let ok = UIAlertAction(title: "Ок", style: .default)
        let alertController = getAlertController(title: "", message: validationErrorDescription, actions: [ok])
        viewController?.display(alertController: alertController)
    }
    
    func presentRestorePasswordAlert() {
        let ok = UIAlertAction(title: "Отправить", style: .default)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let title = "Забыли пароль?"
        let message = "Мы отправим вам ссылку для восстановления пароля на ваш email."
        let alertController = getAlertController(title: title, message: message, actions: [ok, cancel])
        alertController.addTextField()
        let textField = alertController.textFields?[0]
        textField?.placeholder = "Введите ваш email."
        alertController.preferredAction = ok
        viewController?.display(alertController: alertController)
    }
    
    func presentFetchedWheather(_ response: Authentication.Response) {
        let ok = UIAlertAction(title: "Ок", style: .default)
        let message = """
        Температура: \(response.temperature)
        Давление: \(response.pressure) hPa
        Влажность: \(response.humidity)%
        """
        let alertController = getAlertController(title: "Сейчас за бортом.", message: message, actions: [ok])
        viewController?.display(alertController: alertController)
    }
    
    private func getAlertController(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
}
