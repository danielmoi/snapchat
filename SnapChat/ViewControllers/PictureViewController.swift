//
//  PictureViewController.swift
//  SnapChat
//
//  Created by Daniel Moi on 27/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit
import FirebaseStorage

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        // once image picked, make background transparent
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        // disable the inputs
        nextButton.isEnabled = false
        descriptionTextField.isEnabled = false
        
        let fileName = NSUUID().uuidString
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
        
        let imagesFolder = Storage.storage().reference().child("images")
        
        imagesFolder.child("\(fileName).jpg").putData(imageData, metadata: nil, completion: { (metadata, error) in
            print("Uploading...")
            if error != nil {
                print("We had an error:\(error)")
            } else {
                let urlString = metadata?.downloadURL()!.absoluteString
                self.performSegue(withIdentifier: "selectUserSegue", sender: urlString)
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.desc = descriptionTextField.text!
        nextVC.imageURL = sender as! String
        
        
    }
}
