//
//  UpdateProfileViewController.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-12.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit
import FirebaseFirestore

class UpdateProfileViewController: UIViewController {

    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var updateButtonOutlet: UIButton!
    
    @IBOutlet weak var lastName: UITextField!
    
    
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonOutlet.layer.cornerRadius = 20
        getInfoFromFirebase()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getInfoFromFirebase()
    }
    override func viewWillAppear(_ animated: Bool) {
        getInfoFromFirebase()
    }
    func getInfoFromFirebase(){
        let db = Firestore.firestore()
        db.collection("userInfo").getDocuments { (snapshot, error) in
             if error == nil && snapshot != nil{
                 for document in snapshot!.documents{
                     let docData = document.data()
                     
                     if let usename = docData["username"] as? String{
                        self.userName.text = usename
                    }
                    if let firstNa = docData ["firstname"] as? String{
                        self.firstName.text = firstNa
                    }
                    if let lastNa = docData["lastname"] as? String{
                        self.lastName.text = lastNa
                    }
                    
                 }
             }
         }
        db.collection("feeds").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents{
                    let docData = document.data()
                    if let location = docData["location"] as? String{
                        self.country.text = location
                        }
                }
            }
        }
    }
    @IBAction func updateButton(_ sender: Any) {
//        let vc = ProfileViewController()
//        navigationController?.popToViewController(vc, animated: true)
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
