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
    var locationArray = [String]()
    var userNamesArray = [String]()
    var firstName = ""
    var userName = ""
    var imagesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  retrieveFirst()
        
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    zoomtransition()
    
        // Do any additional setup after loading the view.
       // saveDataInFarebase()
    loadImageFeeds()
    getDatabaseFeed()
    getUsersName()
        //print(feedsArray)
        
      
    }

    func zoomtransition(){
        let animation = AnimationType.zoom(scale: 1.0)
        view.animate(animations: [animation])
        
        let cells = tableView.visibleCells(in: 1)
        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
            
        UIView.animate(views: cells, animations: [zoomAnimation, rotateAnimation])
           
        UIView.animate(views: tableView.visibleCells,
                           animations: [fromAnimation, zoomAnimation],
                           delay: 0.5)
    }
    override func viewDidAppear(_ animated: Bool) {
        zoomtransition()
        //loadImageFeeds()
       // getDatabaseFeed()
        //getUsersName()
        
    }
    override func viewWillAppear(_ animated: Bool) {
      //  loadImageFeeds()
        //getDatabaseFeed()
        zoomtransition()
        //getUsersName()
    }
    
    
    @IBAction func signOutButton(_ sender: Any) {
        self.signUserOut()
            let vc = storyboard?.instantiateViewController(identifier: "homeCell") as? HomeViewController
                view.window?.rootViewController = vc
                view.window?.makeKeyAndVisible()
    }
    
       func transitionView(){
   
            let vc = storyboard?.instantiateViewController(identifier: "cellNav") as? NavgationViewController
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

    func loadImageFeeds(){
//        let db = Firestore.firestore()
//        db.collection("feeds").getDocuments { (snapshot, error) in
//            if error == nil && snapshot != nil{
//                print("error retrieving image: \(String(describing: error))")
//            }else{
//                for image in snapshot!.documents{
//
//                        let fbImage = image.data()
//
//                        if let foto = fbImage["image"] as? String{
//                            self.imagesArray.append(foto)
//
//
//
//                        }
//                    }
//
////                self.imagesArray = snapshot!.documents.compactMap({($0.data())})
////                DispatchQueue.main.async {
////                    self.tableView.reloadData()
////                }
//                self.tableView.reloadData()
//            }
//        }
//
//
    }
}
extension FeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let length = feedsArray.filter{ $0.count > 0}
        return length.count
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let headerView = UIView()
              headerView.backgroundColor = UIColor.clear
              return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! feedTableViewCell
//        if feedsArray.count == imagesArray.count  {
//             let images = imagesArray[indexPath.row]
//            for im in self.imagesArray {
//                let url = URL(string: im)
//                DispatchQueue.global().async {
//                                   let data = try? Data(contentsOf: url!)
//                                   DispatchQueue.main.async {
//                                    if data != nil{
//                                       cell.imageView?.image = UIImage(data: data!)
//                                    }else{
//                                        cell.imageView?.image = nil
//                                    }
//                                   }
//                               }
//            }
//        }
        
        
       
        //}
        
        cell.postInCell.text = feedsArray[indexPath.row]
        cell.durationInCell.text = timeArray[indexPath.row]
        cell.locationInCell.text = locationArray[indexPath.row]
        cell.countryInCell.text = userName
        

       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func getUsersName(){
        let db = Firestore.firestore()
        db.collection("userInfo").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for name in snapshot!.documents{
                    
                    let userName = name.data()
                    
                    if let aUser = userName["username"] as? String{
                        self.userName = aUser
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
                        
                        if post.isEmpty{
                            print("there was no post")
                        }else{
                        self.feedsArray.append(post)
                        }

                    }
                    if let time = documentData["date"] as? String{
                        self.timeArray.append(time)
                    }
                    if let location = documentData["location"] as? String{
                        self.locationArray.append(location)
                    }
                    if let image = documentData["image"] as? String{
                        self.imagesArray.append(image)
                        //let url = URL(string: image)

                }
            }
            print(self.feedsArray)
            print(self.timeArray)
            self.tableView.reloadData()
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


