//
//  SnapsViewController.swift
//  SnapChat
//
//  Created by Daniel Moi on 27/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var snapsTableView: UITableView!
    
    
    // Snaps for the current user
    var snaps: [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        snapsTableView.dataSource = self
        snapsTableView.delegate = self
        
        
        let currentUserId = Auth.auth().currentUser!.uid
        print(currentUserId)

        Database.database().reference().child("users").child(currentUserId).child("snaps").observe(DataEventType.childAdded, with: { (snapshot) in
            print("WE GOT DATA")
            // this gets called once FOR EACH user in the database
            let snap = Snap()
            
            let data = snapshot.value as! NSDictionary
            print(data)
            
            snap.desc = data["description"] as! String
            snap.from = data["from"] as! String
            snap.imageURL = data["imageURL"] as! String
            
            self.snaps.append(snap)

            self.snapsTableView.reloadData()
        
        })
    }

    

    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        print(snaps[indexPath.row])
        cell.textLabel?.text = snaps[indexPath.row].from
        return cell
    }
    
    
}
