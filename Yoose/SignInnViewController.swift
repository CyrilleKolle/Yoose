//
//  SignInnViewController.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-09.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInnViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var error: UILabel!
    
    @IBOutlet weak var signInButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            setUpElements();
        // Do any additional setup after loading the view.
    }
    func setUpElements(){
        
        error.alpha = 0;
        
        Utilities.styleTextField(textField: email)
        Utilities.styleTextField(textField: password)
        
        Utilities.styleFilledButton(button: signInButtonOutlet)
        
    }

    

    @IBAction func signIn(_ sender: Any) {
        
        let emaill = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let passw = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: emaill, password: passw) { (result, errorr) in
            
            if errorr != nil{
                self.error.text = errorr?.localizedDescription
                self.error.alpha = 1
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "cell") as! FeedViewController
                let navigationController = UINavigationController(rootViewController: vc)
                  self.present(navigationController, animated: true, completion: nil)
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

}
