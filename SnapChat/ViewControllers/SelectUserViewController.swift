//
//  SelectUserViewController.swift
//  SnapChat
//
//  Created by Daniel Moi on 28/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var usersTableView: UITableView!
    
    var users: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.usersTableView.dataSource = self
        self.usersTableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            // this gets called once FOR EACH user in the database
            let user = User()
            
            let data = snapshot.value as! NSDictionary

            let email = data["email"] as! String
            user.email = email
            user.uid = snapshot.key
            
            
            self.users.append(user)
            
            self.usersTableView.reloadData()
            
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}