//
//  SnapViewController.swift
//  SnapChat
//
//  Created by Daniel Moi on 28/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth

class SnapViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descLabel.text = snap.desc
        
        imageView.sd_setImage(with: URL(string: snap.imageURL), completed: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let currentUserId = Auth.auth().currentUser!.uid
        
        Database.database().reference().child("users").child(currentUserId).child("snaps").child(snap.key).removeValue()
    }


}
