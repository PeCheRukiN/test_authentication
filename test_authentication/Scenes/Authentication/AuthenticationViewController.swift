//
//  AuthenticationViewController.swift
//  test_authentication
//
//  Created by PeCheRukiN on 17.05.2018.
//  Copyright (c) 2018 pecherukin. All rights reserved.
//

import UIKit
import CoreLocation

protocol AuthenticationDisplayLogic: class {
    func display(alertController: UIAlertController)
}

class AuthenticationViewController: UIViewController, AuthenticationDisplayLogic, CLLocationManagerDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
    
    var interactor: AuthenticationBusinessLogic?
    var router: (NSObjectProtocol & AuthenticationRoutingLogic)?
    
    // MARK: Object lifecycle
    
    private var locationManager: CLLocationManager?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = AuthenticationInteractor()
        let presenter = AuthenticationPresenter()
        let router = AuthenticationRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        addObservers()
        hideKeyboardWhenTappedAround()
        configureLocationManager()
    }
    
    fileprivate func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        }
    }
    
    fileprivate func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    fileprivate func setupButtons() {
        logInButton.layer.cornerRadius = logInButton.bounds.height/2
        forgotPasswordButton.layer.cornerRadius = 4
        forgotPasswordButton.layer.borderWidth = 1
        forgotPasswordButton.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
    }
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        guard
            let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
            else { return }
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        UIView.animate(withDuration: duration) {
            self.scrollViewBottomConstraint.constant = keyboardRectangle.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        guard
            let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
            else { return }
        UIView.animate(withDuration: duration) {
            self.scrollViewBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
            else { return }

        let request = Authentication.Request(email: email, password: password, location: locationManager?.location?.coordinate)
        interactor?.logIn(request)
    }
    
    @IBAction func restorePassword(_ sender: UIButton) {
        interactor?.restorePassword()
    }
    
    func display(alertController: UIAlertController) {
        self.present(alertController, animated: true)
    }
}
