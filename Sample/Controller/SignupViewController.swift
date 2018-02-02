//
//  SignupViewController.swift
//  Sample
//
//  Created by Samarth Paboowal on 31/01/18.
//  Copyright © 2018 Samarth Paboowal. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class SignupViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signupButton.layer.masksToBounds = true
        signupButton.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 75
    }

    
    //MARK: - User Defined Methods
    
    @IBAction func signupTapped(_ sender: UIButton) {
        
        if nameField.text?.count == 0 || emailField.text?.count == 0 || (passwordField.text?.count)! < 6 {
            return
        }
        
        if let name = nameField.text {
            if let email = emailField.text {
                if let password = passwordField.text {
                    let newUser = User()
                    let result = newUser.addUser(name: name, email: email, password: password)
                    
                    if result {
                        LoggedUser.saveLoggedInUser(name: name, email: email)
                        UserDefaults.standard.set(true, forKey: "LOGGED_IN")
                        navigateToViewController()
                    } else {
                        showSignupError()
                    }
                }
            }
        }
        
    }
    
    func navigateToViewController() {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "homeVC")
        let navigation = UINavigationController(rootViewController: viewController)
        UIApplication.shared.keyWindow?.rootViewController = navigation
    }
    
    func showSignupError() {
        
        let signupAlert = UIAlertController(title: "Oops!", message: "Email id already registered", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            self.nameField.text = ""
            self.emailField.text = ""
            self.passwordField.text = ""
        }
        signupAlert.addAction(okayAction)
        
        self.present(signupAlert, animated: true, completion: nil)
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
