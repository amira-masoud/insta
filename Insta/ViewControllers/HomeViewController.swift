//
//  HomeViewController.swift
//  Insta
//
//  Created by Amira on 12/18/19.
//  Copyright © 2019 Amira. All rights reserved.
//

import UIKit
import FirebaseAuth
import  FirebaseDatabase

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadPosts()
    }
    func loadPosts() {
       // print(dispatchMain())
        Database.database().reference().child("posts").observe(.childAdded) {(snapshot : DataSnapshot) in
            if let dict = snapshot.value as? [String: Any] {
            let captionText = dict["caption"] as! String
            let photoUrlString = dict["photoUrl"] as! String
            let post = Post(captionText: captionText, photoUrlString: photoUrlString)
                self.posts.append(post)
                print(self.posts)
                self.tableView.reloadData()
                
            }
           
        }
    }
    
    @IBAction func logoutBTN(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()        }
        catch let logoutError {
            print(logoutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
    }
}

    
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].caption
        return cell
    
    
    }
}
