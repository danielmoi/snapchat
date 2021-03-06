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
        
        // When something is ADDED to snaps, update
        Database.database().reference().child("users").child(currentUserId).child("snaps").observe(DataEventType.childAdded, with: { (snapshot) in
            print("childAdded")
            // this gets called once FOR EACH snap in the database
            let snap = Snap()
            
            let data = snapshot.value as! NSDictionary
            print(data)
            
            snap.desc = data["description"] as! String
            snap.from = data["from"] as! String
            snap.imageURL = data["imageURL"] as! String
            snap.key = snapshot.key
            snap.uuid = data["uuid"] as! String
            
            self.snaps.append(snap)
            
            self.snapsTableView.reloadData()
        })
        
        // when something is REMOVED from snaps, update
        Database.database().reference().child("users").child(currentUserId).child("snaps").observe(DataEventType.childRemoved, with: { (snapshot) in
            print("childRemoved")
            // gross
            var index = 0
            for snap in self.snaps {
                print("OMG")
                print(snapshot.key)
                if snap.key == snapshot.key {
                    print("REMOVING....")
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            self.snapsTableView.reloadData()
            
        })
    }
    
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0 {
            return 1
        } else {
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            cell.textLabel?.text = "No snaps :("
            
        } else {
            cell.textLabel?.text = snaps[indexPath.row].from
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if snaps.count > 0 {
            let snap = snaps[indexPath.row]
            performSegue(withIdentifier: "viewSnapSegue", sender: snap)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "viewSnapSegue") {
            let nextVC = segue.destination as! SnapViewController
            nextVC.snap = sender as! Snap
        }
        
        
    }
    
    
}
