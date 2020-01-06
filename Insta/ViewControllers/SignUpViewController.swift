//
//  SignUpViewController.swift
//  Insta
//
//  Created by Amira on 12/18/19.
//  Copyright © 2019 Amira. All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc func textFieldDidChange() {
        guard let username = usernameTextField.text, !username.isEmpty, let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty
            else {
                signBTN.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
                signBTN.isEnabled = false
                return
        }
        signBTN.setTitleColor(UIColor.white, for: UIControl.State.normal)
        signBTN.isEnabled = true
    }
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signBTN: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.tintColor = UIColor.white
        usernameTextField.textColor = UIColor.white
        usernameTextField.attributedPlaceholder = NSAttributedString(string: usernameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerUsername = CALayer()
        bottomLayerUsername.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerUsername.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        usernameTextField.layer.addSublayer(bottomLayerUsername)
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)
        
        profileImage.layer.cornerRadius = 40
        profileImage.clipsToBounds = true
        signBTN.isEnabled = false
        
        func handleTextField() {
            usernameTextField.addTarget(self, action:#selector(SignUpViewController.textFieldDidChange) , for: UIControl.Event.editingChanged)
            emailTextField.addTarget(self, action:#selector(SignUpViewController.textFieldDidChange) , for: UIControl.Event.editingChanged)
            passwordTextField.addTarget(self, action:#selector(SignUpViewController.textFieldDidChange) , for: UIControl.Event.editingChanged)
        }
        handleTextField()
  
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func Dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageButton(_ sender: Any) {
        // de 3shan lma ados  yft7li el gallary
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
            imagePicker.delegate = self
            
        }
        
        
        //de 3shan lma a5tar photo mn elgallary y7thali fe el imagview bta3y
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            
            guard let selectedImage = info[.originalImage]  else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
            profileImage.image = selectedImage as! UIImage
            profileImage.contentMode = .scaleAspectFill
            profileImage.clipsToBounds = true
            
        }
       
       
        
    }
    @IBAction func signUpBtn(_ sender: Any) {
       view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        Auth.auth().createUser(withEmail:emailTextField.text!, password:passwordTextField.text!, completion: { (user, error) in
            if error != nil {
                
                return
            }
            let uid = user?.user.uid
            let storageRef = Storage.storage().reference(forURL: "gs://insta-2f9fe.appspot.com").child("profile_image").child((user?.user.uid)!)
            if let profileImg = self.profileImage, let imageData = UIImage().jpegData(compressionQuality: 0.1){
                storageRef.putData(imageData, metadata: nil, completion: { (UserMetadata, error) in
                    
                    if error != nil {
                        
                        return
                    }
                    
                    let profileImageUrl = UserMetadata?.storageReference?.downloadURL(completion: )
                    
                    let ref = Database.database().reference()
                    let usersReference = ref.child("users")
                    let newUserReference = usersReference.child(uid!)
                    newUserReference.setValue(["username": self.usernameTextField.text!, "email": self.emailTextField.text!, "profileImageUrl": profileImageUrl])
                    
                })
                
            }
        })
        
        
        self.performSegue(withIdentifier: "SignUP", sender: nil )
        }



}
