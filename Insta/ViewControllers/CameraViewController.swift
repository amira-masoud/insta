//
//  CameraViewController.swift
//  Insta
//
//  Created by Amira on 12/18/19.
//  Copyright © 2019 Amira. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import ImagePicker

class CameraViewController: UIViewController, ImagePickerDelegate  {
   

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var removeButtonOultlet: UIBarButtonItem!
    var selectedImage : UIImage?
    
  

   override func viewDidLoad() {
      super.viewDidLoad()
    // bt3ml action lel imageview
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlerSelectedphoto))
    photo.addGestureRecognizer(tapGesture)
    photo.isUserInteractionEnabled = true
    
    }
    @objc func handlerSelectedphoto()
    {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    @IBAction func cameraButton_Touch(_ sender: Any) {
        let imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 5
        present(imagePickerController, animated: true, completion: nil)
    }
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]){
        guard let image = images.first else {
            dismiss(animated: true, completion: nil)
            return
        }
        selectedImage = image
        photo.image = image
        dismiss(animated: true, completion: nil)
       // self.performSegue(withIdentifier: "filter_segue", sender: nil)
    }
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {}
    
    // bt8yer shakl el zorar w lono
    func handlePost() {
        if selectedImage != nil {
            self.shareButton.isEnabled = true
            self.removeButtonOultlet.isEnabled = true
            self.shareButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            self.shareButton.isEnabled = false
            self.removeButtonOultlet.isEnabled = false
            self.shareButton.backgroundColor = UIColor.lightGray
        }
    }
    // dismiss keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    

 
    @IBAction func shareButton_Touch(_ sender: Any) {
        ProgressHUD.show("Waiting...", interaction: false)
        if let profileImg = self.selectedImage, let imageData = UIImage().jpegData(compressionQuality: 0.1){
            let photoIdString = NSUUID().uuidString
            print(photoIdString)
            let storageRef = Storage.storage().reference().child("photo").child(photoIdString)
            storageRef.putData(imageData, metadata: nil, completion: {(metadata, error) in
                if error != nil {
                    ProgressHUD.showError("This photo can't be loaded")
                    return
                }
                let photoUrl =  storageRef.downloadURL(completion:{ (photoUrl , error) in
                    self.sendDataToDatabase(photoUrl: photoUrl!.absoluteString )
                })
            })
           
        } else {
            ProgressHUD.showError("This photo can't be loaded")
        }
        
    }
    
    @IBAction func removeButton(_ sender: Any) {
        clean()
        handlePost()
    }
    
    func  sendDataToDatabase(photoUrl: String){
        let ref = Database.database().reference()
        let postsReference = ref.child("posts")
        let newPostId = postsReference.childByAutoId().key
        let newPostReference = postsReference.child(newPostId!)
        newPostReference.setValue(["photoUrl": photoUrl, "Caption": captionTextView.text!], withCompletionBlock: {(error, ref) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            ProgressHUD.showSuccess("Success")
            self.clean()
            self.tabBarController?.selectedIndex = 0
        })
    }
    // func btms7 elsora wl caption
    func clean() {
        self.captionTextView.text = ""
        self.photo.image = UIImage(named: "placeholderImg")
        self.selectedImage = nil
    }
}


extension CameraViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    
    //func 3shan t7otly el image elli ana a5trtha mn el gallery fe el image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage = image
            photo.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
