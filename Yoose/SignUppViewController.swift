//
//  SignUppViewController.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-09.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Hero


class SignUppViewController: UIViewController {
     var panGR: UIPanGestureRecognizer!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var error: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }

    
    func setUpElements(){
        
        error.alpha = 0;
        
        Utilities.styleTextField(textField: firstName)
        Utilities.styleTextField(textField: lastName)
        Utilities.styleTextField(textField: email)
        Utilities.styleTextField(textField: password)
        
    }
    func validateFields() -> String?{
        
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "please fill all fields"
        }
        
        let cleanedPasswrd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
       if  Utilities.isPasswordValid( password: cleanedPasswrd)  == false{
            
            return "password must contain 8 characters, a special character, number"
        }
        
        return nil
    }

    @IBAction func signUp(_ sender: Any) {
            
                let errorr = validateFields()

                if errorr != nil {

                    //error.text = errorr!
                  error.alpha = 1

                    showError(errorr!)
                }else{
                    let firstN = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let lastN = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let emaill = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    let passW = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    Auth.auth().createUser(withEmail: emaill, password: passW) { (result, err) in
                        if err != nil{
                            self.showError("error creating user")
                            
                        }else{

                            let db = Firestore.firestore()
                            db.collection("users").addDocument(data: ["firstName": firstN,"lastName": lastN, "uid":result!.user.uid ]) {( error) in
                                
                                if error != nil{
                                    self.showError("try again later, error saving data")
                                }
                            }
                            self.transitionView()
                        }
                    }
                }
    }
    func showError(_ message: String){
        
        error.text = message
        error.alpha = 1
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
