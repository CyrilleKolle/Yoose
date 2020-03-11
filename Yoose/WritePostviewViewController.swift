//
//  WritePostviewViewController.swift
//  
//
//  Created by Indigo´sDad on 2020-03-09.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseFirestore
import ViewAnimator


class WritePostviewViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
    
    @IBOutlet weak var viewOnImage: UIView!
    
    @IBOutlet weak var imageInput: UIImageView!
    
    
    @IBOutlet weak var writeInputPost: UITextView!
    var imagePicker:UIImagePickerController!
    
    @IBOutlet weak var writeLabelInput: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomtransition()
        viewOnImage.alpha = 0
        //let db = Firestore.firestore()

    }
    override func viewWillAppear(_ animated: Bool) {
        zoomtransition()
    }
    override func viewDidAppear(_ animated: Bool) {
        zoomtransition()
    }
    func zoomtransition(){
        let animation = AnimationType.zoom(scale: 1.5)
        view.animate(animations: [animation])
    }
      func transitionView(){
    
          let vc = storyboard?.instantiateViewController(identifier: "cell") as? FeedViewController
          view.window?.rootViewController = vc
          view.window?.makeKeyAndVisible()
      }
    
    @IBAction func PostButton(_ sender: Any) {

        let postText = writeInputPost.text
        
        let db = Firestore.firestore()
        //db.collection("feeds").addDocument(data: ["post":"postCreated"])
        db.collection("feeds").addDocument(data: ["post":postText ?? "nothing to display"]){(error) in
              if let error = error {
                 print("there was an error saving to firebase: \(error)")
              }
              else{
                print("Data successfully saved")
                  let newPost = db.collection("feeds").document()
                  newPost.setData(["post":"postCreated"])
                self.transitionView()
              }
              
          }
        }
        
    @IBAction func cameraButtonForView(_ sender: Any) {
        viewOnImage.alpha = 1
    }
    
    @IBAction func imageButtonForLibrary(_ sender: Any) {
        
        viewOnImage.alpha = 0
        let image = UIImagePickerController ()
                   image.delegate = self
                   image.sourceType = UIImagePickerController.SourceType.photoLibrary
                   image.allowsEditing = false
                   self.present(image, animated: true) {
                       
                   }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
              imageInput.image = image
          }
      }
    
    @IBAction func imageButtonForCamera(_ sender: Any) {
        viewOnImage.alpha = 0
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType .camera) {
                 let imagePicker = UIImagePickerController()
                 imagePicker.delegate = self
              imagePicker.sourceType = UIImagePickerController.SourceType.camera
                 imagePicker.allowsEditing = false
                 self.present(imagePicker, animated: true, completion: nil)
             }
         
    }
    
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



