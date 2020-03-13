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
import CoreLocation
import FirebaseStorage



class WritePostviewViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate  {
    
    let locationManager = CLLocationManager()
    var username = ""
    @IBOutlet weak var viewOnImage: UIView!
    
    @IBOutlet weak var imageInput: UIImageView!
    var timeStamped: Date!
    var photo: UIImage!
    var timeArray = [String]()
    var myLocation = ""
    var myString = ""
    var postIt = [Post]()
    @IBOutlet weak var writeInputPost: UITextView!
    var imagePicker:UIImagePickerController!
    
    @IBOutlet weak var writeLabelInput: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestAlwaysAuthorization()

           if CLLocationManager.locationServicesEnabled(){
               locationManager.startUpdatingLocation()
           }
        
        
        zoomtransition()
        viewOnImage.alpha = 0
        //let db = Firestore.firestore()

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

    //    print("user latitude = \(userLocation.coordinate.latitude)")
   //     print("user longitude = \(userLocation.coordinate.longitude)")

//        self.labelLat.text = "\(userLocation.coordinate.latitude)"
//        self.labelLongi.text = "\(userLocation.coordinate.longitude)"

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                
                //self.myLocation = String(placemark.location!)
                
                if let loc = placemark.country{
                    self.myLocation = loc
                }
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
             

               // self.labelAdd.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
            }
        }

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
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
    
          let vc = storyboard?.instantiateViewController(identifier: "cellNav") as? NavgationViewController
        view.window?.rootViewController = vc
        //view.window?.inputViewController = vc
          view.window?.makeKeyAndVisible()
        
      }
    
    @IBAction func PostButton(_ sender: Any) {
        
        
       // let postText = writeInputPost.text
        //let db = Firestore.firestore()
        let postText = self.writeInputPost.text
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMMyyyy-hh:mm"
        let myString = formatter.string(from: Date())
        print("time stamped is: \(myString)")
        
        
         let db = Firestore.firestore()
         //db.collection("feeds").addDocument(data: ["post":"postCreated"])
         db.collection("feeds").addDocument(data: ["post":postText ?? "",
         "date":myString,
         "location": self.myLocation]){(error) in
               if let error = error {
                  print("there was an error saving to firebase: \(error)")
               }
               else{
                 print("Data successfully saved")
                 self.transitionView()
               }
               
           }
//        let storageRef = Storage.storage().reference().child("foto.png")
//               if let uploadData = self.imageInput.image?.pngData(){
//                   storageRef.putData(uploadData, metadata: nil) {(metadata, error) in
//
//                       if error != nil{
//                           print("there was an error: \(String(describing: error))")
//                           return
//                       }else{
//                        print("successfully saved image to storage")
//
//                           storageRef.downloadURL { (url, error) in
//                               let db = Firestore.firestore()
//                            let postText = self.writeInputPost.text
//                                 let formatter = DateFormatter()
//                                 formatter.dateFormat = "ddMMMyyyy-hh:mm"
//                                 let myString = formatter.string(from: Date())
//                                 print("time stamped is: \(myString)")
//                            db.collection("feeds").addDocument(data: ["post":postText ?? "",
//                            "date":myString,
//                            "location": self.myLocation,
//                            "image": (url?.absoluteString)!])
//
//
//                               self.transitionView()
//                           }
//                       }
//
//
//                   }
//
//               }
    
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
            photo = image
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
    func saveImageToStorage(){
       // let db = Firestore.firestore()
        
//        db.collection("users").getDocuments { (snapshot, error) in
//                 if error == nil && snapshot != nil {
//                     for name in snapshot!.documents{
//
//                        let userName = name.data()
//
//                         if let aUser = userName["username"] as? String{
//                             //self.userNamesArray.append(aUser)
//
//                            self.username = aUser
//                         }
//
//                     }
//
//
//    }
//        let db = Firestore.firestore()
//            let storageRef = Storage.storage().reference().child("foto.png")
//            if let uploadData = self.imageInput.image?.pngData(){
//                storageRef.putData(uploadData, metadata: nil) {(metadata, error) in
//
//                    if error != nil{
//                        print("there was an error: \(String(describing: error))")
//                        return
//                    }else{
//                        storageRef.downloadURL { (url, error) in
//                            let db = Firestore.firestore()
//                            db.collection("feeds").document("image").setData(["image":(url?.absoluteString)!])
//                        }
//                    }
//
//                }
//            }
//
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

