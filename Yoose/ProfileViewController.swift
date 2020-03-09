//
//  ProfileViewController.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-09.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {


    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameOutlet: UITextField!
    
    @IBOutlet weak var lastNameOutlet: UITextField!
    @IBOutlet weak var countryOutlet: UITextField!
    
    var firstName = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveButtonOutlet.layer.cornerRadius = 20
        let defaults = UserDefaults.standard
        if (defaults.object(forKey: "fn") as? String) != nil {
            self.firstName = lastNameOutlet.text!

        } else {
            firstName = "Welcome"
        }
        saveNameInfos()
    }
    func saveNameInfos(){
         let defaults = UserDefaults.standard
       
           defaults.set(self.firstName, forKey: "fn")
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             profileImage.image = image
         }
     }

    @IBAction func takeProfilePicture(_ sender: Any) {
        let image = UIImagePickerController ()
                  image.delegate = self
                  image.sourceType = UIImagePickerController.SourceType.photoLibrary
                  image.allowsEditing = false
                  self.present(image, animated: true) {
                      
                  }
    }
    
    @IBAction func cameProfilePicture(_ sender: Any) {
        print("button clicked")
          //let picker = UIImagePickerController()
       if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType .camera) {
               let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
               imagePicker.allowsEditing = false
               self.present(imagePicker, animated: true, completion: nil)
           }
    }
    @IBAction func saveInfoButton(_ sender: Any) {
        saveNameInfos()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
