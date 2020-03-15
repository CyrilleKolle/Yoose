//
//  Utilities.swift
//  swiftFirstClass
//
//  Created by Indigo´sDad on 2020-02-01.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    static func styleTextField( textField: UITextField){
        
        
        //creates the bottomlone
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect (x: 0, y: textField.frame.height - 2, width: textField.frame.width
        , height: 2)
        
       // bottomLine.backgroundColor = UIColor.init(red: 48/255, green:  173/255, blue: 99/255, alpha: 1).cgColor
        bottomLine.backgroundColor = UIColor.init(red: 48/200, green: 110/200, blue: 180, alpha: 1).cgColor
        //remove border on textfield
        textField.borderStyle = .none
        
        //add the line to the text field
        textField.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton ( button : UIButton){
        
        //filled rounded corner style
        //button.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        button.backgroundColor = UIColor.init(red: 48/200, green: 110/200, blue: 180, alpha: 1)
        //button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton (button : UIButton){
        //hollow rounded corner style
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid ( password : String) -> Bool{
        
        //let passwordTest = NSPredicate(format: "SELF MATCHES %@", "1234567890-098765RTY890-P;.,MNM,./;LKMNBVF")
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        return passwordTest.evaluate(with: password)
    }

}
