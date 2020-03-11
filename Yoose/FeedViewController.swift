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
import ViewAnimator

class FeedViewController: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    
    @IBOutlet weak var tableView: UITableView!
    let country = Countries()
    var feedsArray = [String]()
    var timeStamped: Date!
    var timeArray = [String]()
    var userNamesArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        zoomtransition()
        let cells = tableView.visibleCells(in: 1)
               let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
               let zoomAnimation = AnimationType.zoom(scale: 0.2)
               let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
        
        //UIView.animate(views: cells, animations: [zoomAnimation, rotateAnimation])
       
        UIView.animate(views: tableView.visibleCells,
                       animations: [fromAnimation, zoomAnimation],
                       delay: 0.5)
        // Do any additional setup after loading the view.
       // saveDataInFarebase()
        loadFeeds()
        getDatabaseFeed()
        print(feedsArray)
      
    }
    func zoomtransition(){
        let animation = AnimationType.zoom(scale: 1.5)
        view.animate(animations: [animation])
    }
    override func viewDidAppear(_ animated: Bool) {
        zoomtransition()
        let cells = tableView.visibleCells(in: 1)
               let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
               let zoomAnimation = AnimationType.zoom(scale: 0.2)
               let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
        UIView.animate(views: cells, animations: [zoomAnimation, rotateAnimation])
    }
    
    
    @IBAction func signOutButton(_ sender: Any) {
        self.signUserOut()
        self.transitionView()
    }
       func transitionView(){
   
            let vc = storyboard?.instantiateViewController(identifier: "homeCell") as? HomeViewController
            view.window?.rootViewController = vc
            view.window?.makeKeyAndVisible()
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
        return feedsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! feedTableViewCell
        cell.postInCell.text = feedsArray[indexPath.row]
        //cell.countryInCell.text = userNamesArray[indexPath.row]
        //cell.durationInCell.text = timeArray[indexPath.row]
       
        return cell
    }
    func getUsersName(){
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for name in snapshot!.documents{
                    
                    let userName = name.data()
                    
                    if let aUser = userName["firstName"] as? String{
                        self.userNamesArray.append(aUser)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    func getDatabaseFeed(){
        let db = Firestore.firestore()
        db.collection("feeds").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil{
                
                for document in snapshot!.documents{
                    let documentData =  document.data()
                    
                    print("\(documentData)")

                    if let post = documentData["post"] as? String {
                        //self.thumbnail_images.append(ThumbImages(dict: postImage))
                        self.feedsArray.append(post)
                        
                        
                    }
//                    guard let stamp = documentData["post"] as? Timestamp else {
//                        return
//                    }
//                    var datee = stamp.dateValue()
//
//                    //self.timeStamped = date
//                    let formatter = DateFormatter()
//                    // initially set the format based on your datepicker date / server String
//                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//                    let myString = formatter.string(from: Date()) // string purpose I add here
//                    // convert your string to date
//                    datee = formatter.date(from: myString)!
//                    //then again set the date format whhich type of output you need
//                    formatter.dateFormat = "dd-MMM-yyyy"
//                    // again convert your date to string
//                    let dateString = formatter.string(from: datee)
//                    self.timeArray.append(dateString)
//
//                    print("time stamped: \( dateString)")
                }
                print(self.feedsArray)
                print (self.timeArray)
                self.tableView.reloadData()
            }
        }
    }
    
  
    }
//func getTimeStamp(){
////    import FirebaseFirestore
//    init?(document: QueryDocumentSnapshot) {
//            let data = document.data()
//           guard let stamp = data["timeStamp"] as? Timestamp else {
//                return nil
//            }
//           let date = stamp.dateValue()
//    }
//}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


