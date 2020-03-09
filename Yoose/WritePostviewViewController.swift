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


class WritePostviewViewController: UIViewController {
    @IBOutlet weak var writeInputPost: UITextView!
    
    @IBOutlet weak var writeLabelInput: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = Firestore.firestore()
            //db.collection("feeds").addDocument(data: ["post":"postCreated"])
//        let newPost = db.collection("feeds").document()
//        newPost.setData(["post":"postCreated"])
        
//        db.collection("feeds").addDocument(data: ["post":"post"]){(error) in
//            if let error = error {
//               print("there was an error saving to firebase: \(error)")
//            }
//            else{
//                let newPost = db.collection("feeds").document()
//                newPost.setData(["post":"postCreated"])
//            }
//
//        }
        // Do any additional setup after loading the view.
        //db.collection("feeds").document().delete() --> delete
       // db.collection("feeds").document().updateData(["type":FieldValue.delete()]) -->delete particular data
    }
    
    @IBAction func PostButton(_ sender: Any) {
//        var ref: DatabaseReference!
//
//        ref = Database.database().reference(withPath: "Feeds")
//        let postText = writeLabelInput.text
//        let saveAction = UIAlertAction(title: "Save",
//                                       style: .default) { _ in
//            // 1
////            guard let textField = alert.textFields?.first,
////              let text = textField.text else { return }
//
//            // 2
//            var feedItems  = [String:String]()
//            let groceryItem = feedItems(name: postText,
//                                   addedByUser: self.user.email,
//                                     completed: false)
//            // 3
//            let groceryItemRef = self.ref.child(postText.lowercased())
//
//            // 4
//            groceryItemRef.setValue(groceryItem.toAnyObject())
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
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "cell") as! FeedViewController
              let navigationController = UINavigationController(rootViewController: vc)
                self.present(navigationController, animated: true, completion: nil)
              }
              
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



