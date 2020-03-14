//
//  HomeViewController.swift
//  swiftFirstClass
//
//  Created by Indigo´sDad on 2020-01-31.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit
import Hero
import ViewAnimator
import DSGradientProgressView


class HomeViewController: UIViewController {
//
    @IBOutlet weak var centerImageLogo: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var widthConstrain: NSLayoutConstraint!
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        hideView()
        let animation = AnimationType.zoom(scale: 1.5)
        view.animate(animations: [animation])
    
       }
    override func viewDidAppear(_ animated: Bool) {
        let animation = AnimationType.zoom(scale: 0.5)
        view.animate(animations: [animation])
        showView()
    }
    override func viewWillAppear(_ animated: Bool) {
        let animation = AnimationType.zoom(scale: 0.5)
        view.animate(animations: [animation])
    }

func hideView(){
    widthConstrain.constant -= view.bounds.width
    let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    centerImageLogo.animate(animations: [rotateAnimation], duration: 5.0)
//     -= view.bounds.width
//      centerAlignPassword.constant -= view.bounds.width
      stackView.alpha = 0.0
}
    func showView(){
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            //self.centerAlignUsername.constant += self.view.bounds.width
            self.widthConstrain.constant += self.view.bounds.width
            //self.centerAlignPassword.constant += self.view.bounds.width
            //self.loginButton.alpha = 1
            self.stackView.alpha = 1.0
           // self.view.layoutIfNeeded()
        }, completion: nil)
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


