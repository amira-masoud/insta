//
//  SignInViewController.swift
//  Insta
//
//  Created by Amira on 12/18/19.
//  Copyright © 2019 Amira. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @objc func textFieldDidChange() {
        guard  let email = EmailTextField.text, !email.isEmpty, let password = PasswordTextField.text, !password.isEmpty
            else {
                signInButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
                signInButton.isEnabled = false
                return
        }
        signInButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signInButton.isEnabled = true
    }

    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
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
        signInButton.isEnabled = false
        
        handleTextField()
        
        
        
    }
    // dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
        self.performSegue(withIdentifier: "SignIN", sender: nil )
    }
        
}
    
    func handleTextField() {
        
        EmailTextField.addTarget(self, action:#selector(SignInViewController.textFieldDidChange) , for: UIControl.Event.editingChanged)
        PasswordTextField.addTarget(self, action:#selector(SignInViewController.textFieldDidChange) , for: UIControl.Event.editingChanged)
    }
    @IBAction func singInButtonTouch(_ sender: Any) {
        ProgressHUD.show("Waiting...", interaction: false)
        view.endEditing(true)
        AuthService.signIn(email: EmailTextField.text!, password: PasswordTextField.text!, onSuccess: {
            ProgressHUD.showSuccess("Success")
            self.performSegue(withIdentifier: "SignIN", sender: nil )
        }, onError: {error in
            ProgressHUD.showError(error)
        })
        
    }
}
