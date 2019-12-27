//
//  SignInViewController.swift
//  Insta
//
//  Created by Amira on 12/18/19.
//  Copyright © 2019 Amira. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        EmailTextField.backgroundColor = UIColor.clear
        EmailTextField.tintColor = UIColor.white
        EmailTextField.textColor = UIColor.white
        EmailTextField.attributedPlaceholder = NSAttributedString(string: EmailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        EmailTextField.layer.addSublayer(bottomLayerEmail)
        
        PasswordTextField.backgroundColor = UIColor.clear
        PasswordTextField.tintColor = UIColor.white
        PasswordTextField.textColor = UIColor.white
        PasswordTextField.attributedPlaceholder = NSAttributedString(string: PasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        PasswordTextField.layer.addSublayer(bottomLayerPassword)
        
        
        
        
    }
    
    
    

}
