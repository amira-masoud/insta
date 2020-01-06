//
//  AuthService.swift
//  Insta
//
//  Created by Amira on 12/29/19.
//  Copyright © 2019 Amira. All rights reserved.
//

import Foundation
import FirebaseAuth
class  AuthService {
    static func signIn(email:String, password:String, onSuccess : @escaping () -> Void, onError : @escaping (_ errorMessage : String) -> Void)  {
        Auth.auth().signIn(withEmail: email, password: password, completion:{(user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                
                return
            }
            onSuccess()
        } )
    }
}
