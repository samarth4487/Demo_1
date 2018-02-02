//
//  ViewController.swift
//  Sample
//
//  Created by Samarth Paboowal on 31/01/18.
//  Copyright © 2018 Samarth Paboowal. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 75
    }

    
    //MARK: - User Defined Methods
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        if emailField.text?.count == 0 || (passwordField.text?.count)! < 6 {
            return
        }

        checkForUserInDb()        
    }
    
    func checkForUserInDb() {
        
        let realm = try! Realm()
        let user = realm.objects(User.self).filter("email = %@", emailField.text!)
        
        if user.count == 1 {
            if passwordField.text == user[0].password! {
                
                print("\(user[0].name!) successfully logged in!")
                LoggedUser.saveLoggedInUser(name: user[0].name!, email: user[0].email!)
                UserDefaults.standard.set(true, forKey: "LOGGED_IN")
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "homeVC")
                let navigation = UINavigationController(rootViewController: viewController)
                UIApplication.shared.keyWindow?.rootViewController = navigation
                
            } else {
                displayLoginError()
            }
        } else {
            displayLoginError()
        }
    }
    
    func displayLoginError() {
        
        let loginAlert = UIAlertController(title: "Oops!", message: "Failed to login!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            self.emailField.text = ""
            self.passwordField.text = ""
        }
        loginAlert.addAction(okayAction)
        
        self.present(loginAlert, animated: true, completion: nil)
    }
    
}

