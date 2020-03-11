//
//  TabBarViewController.swift
//  Yoose
//
//  Created by Indigo´sDad on 2020-03-11.
//  Copyright © 2020 Indigo´sDad. All rights reserved.
//

import UIKit
import BATabBarController

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func animateTab(){
        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()

        let tabBarItem  = BATabBarItem(image: UIImage(named: "icon1_unselected")!, selectedImage: UIImage(named: "icon1_selected")!)
        let tabBarItem2 = BATabBarItem(image: UIImage(named: "icon2_unselected")!, selectedImage: UIImage(named: "icon2_selected")!)
        let tabBarItem3 = BATabBarItem(image: UIImage(named: "icon3_unselected")!, selectedImage: UIImage(named: "icon3_selected")!)


        let baTabBarController = BATabBarController()
        baTabBarController.viewControllers = [vc1, vc2, vc3]
        baTabBarController.tabBarItems = [tabBarItem, tabBarItem2, tabBarItem3]
        baTabBarController.delegate = self
        self.view.addSubview(baTabBarController.view)
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
