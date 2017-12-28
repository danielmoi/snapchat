//
//  SnapViewController.swift
//  SnapChat
//
//  Created by Daniel Moi on 28/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descLabel.text = snap.desc 
    }


}
