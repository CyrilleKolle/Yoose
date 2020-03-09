//
//  FeedViewController.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-08.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore

class FeedViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    
    let country = Countries()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // saveDataInFarebase()
        loadFeeds()
    }
    
    
    @IBAction func signOutButton(_ sender: Any) {
        self.signUserOut()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "cell") as! FeedViewController
        let navigationController = UINavigationController(rootViewController: vc)
          self.present(navigationController, animated: true, completion: nil)
        
    }
    func signUserOut (){
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
           
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
//    func saveDataInFarebase(){
//        var ref: DatabaseReference!
//
//        ref = Database.database().reference(withPath: "Feeds")
//        print("reference key\(ref.key)")
//       // self.ref.child("users").child(user.uid).setValue(["username": username])
//        //let ref = Database.database().reference(withPath: "grocery-items")
//    }
    func loadFeeds(){
        let db = Firestore.firestore()
        db.collection("feeds").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil{
                
//                for document in snapshot!.documents{
//                 //   let documentData =  document.data()
//                }
            }
        }
    }
}
extension FeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! feedTableViewCell
        let db = Firestore.firestore()
        db.collection("feeds").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil{
                
                for document in snapshot!.documents{
                    let documentData =  document.data()
                    cell.postInCell.text = documentData["feeds"] as? String
                }
            }
        }
        
        return cell
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


