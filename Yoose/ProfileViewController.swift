//
//  ProfileViewController.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-09.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit
import ViewAnimator
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class ProfileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let FILE_NAME = "images/imageFileTest.jpg"
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameOutlet: UITextField!
    
    @IBOutlet weak var lastNameOutlet: UITextField!
    @IBOutlet weak var countryOutlet: UITextField!
    
    var firstName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomtransition()
        retrieveFirst()
        // Do any additional setup after loading the view.
        saveButtonOutlet.layer.cornerRadius = 20
       // saveNameInfos()
    }
    
    func zoomtransition(){
        let animation = AnimationType.zoom(scale: 1.5)
        view.animate(animations: [animation])
    }
    override func viewDidAppear(_ animated: Bool) {
        zoomtransition()
        retrieveFirst()
    }
    func retrieveFirst(){
        let defaults = UserDefaults.standard
        if (defaults.object(forKey: "fn") as? String) != nil {
                  self.firstName = firstNameOutlet.text!

              } else {
                  firstName = "anonymous"
              }
    }
    func saveNameInfos(){
         let defaults = UserDefaults.standard
       
           defaults.set(self.firstName, forKey: "fn")
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             profileImage.image = image
            
            self.uploadImageToStorage(image){ url in
                
                if url != nil {
                    
                }
                
            }
            
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
    func save(proImageUrl: URL, completion: @escaping ((_ success: Bool) -> ())){
        
        //guard let uid = Auth.auth().currentUser?.uid else { return}
//
//        let databaseRef = Storage.storage().reference().child("usersImage")
//
//        let userObject = ["photoUrl": proImageUrl.absoluteString] as [String:Any]
////        databaseRef.setValue(userObject) { error, ref in
////            //completion(error = nil)
//
//        }
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
//    func loadImageFromFirebase() {
//        let storage = Storage.storage().reference(withPath: FILE_NAME)
//        storage.downloadURL { (url, error) in
//            if error != nil {
//                print((error?.localizedDescription)!)
//                return
//            }
//            print("Download success")
//            self.imageURL = "\(url!)"
//        }
//    }
    func uploadImageToStorage(_ image: UIImage, completion: @escaping ((_ url: URL?)-> ())){
//        let storageRef = Storage.storage().reference()
//
//        // Create a reference to "mountains.jpg"
//        let mountainsRef = storageRef.child("mountains.jpg")
//
//        // Create a reference to 'images/mountains.jpg'
//        let mountainImagesRef = storageRef.child("images/mountains.jpg")

//        // While the file names are the same, the references point to different files
//        mountainsRef.name == mountainImagesRef.name;            // true
//        mountainsRef.fullPath == mountainImagesRef.fullPath;
//        // Data in memory
//        let data = Data()
//
//        // Create a reference to the file you want to upload
//        let riversRef = storageRef.child("images/rivers.jpg")
//
//        // Upload the file to the path "images/rivers.jpg"
//        let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
//          guard let metadata = metadata else {
//            // Uh-oh, an error occurred!
//            return
//          }
//          // Metadata contains file metadata such as size, content-type.
//          let size = metadata.size
//          // You can also access to download URL after upload.
//          riversRef.downloadURL { (url, error) in
//            guard let downloadURL = url else {
//              // Uh-oh, an error occurred!
              return
            }
         // }
      //  }
   // }
    func saveProfileInfoToF(){
        
        let firstNa = firstNameOutlet.text
        let lastNa = lastNameOutlet.text
        //var country = countryOutlet.text
        let userNa = username.text
//        print(firstNa)
//        print(lastNa)
//        print(userNa)
            let db = Firestore.firestore()
            //db.collection("feeds").addDocument(data: ["post":"postCreated"])
        db.collection("userInfo").addDocument(data: ["firstname":firstNa ?? "anonymous","lastname":lastNa ?? "anomymous", "username": userNa ?? "anonymous"]){(error) in
                  if let error = error {
                     print("there was an error saving to firebase: \(error)")
                  }
                  else{
                  
                    print("Data successfully saved")
                   // print("usernamne: \(userNa)")
                    //self.transitionView()
                  }
                  
              }
    }
    @IBAction func saveInfoButton(_ sender: Any) {
        saveProfileInfoToF()
        transitionView()
         //self.navigationController popViewControllerAnimated:YES
    }
      func transitionView(){
    
          let vc = storyboard?.instantiateViewController(identifier: "cellNav") as? NavgationViewController
        
          view.window?.rootViewController = vc
          view.window?.makeKeyAndVisible()
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
