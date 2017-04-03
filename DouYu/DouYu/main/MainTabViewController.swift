//
//  MainTabViewController.swift
//  DouYu
//
//  Created by zc on 2017/4/3.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let vcNameArr = ["Home", "Live", "Focus", "Discovery", "Mine"]
        
        for name in vcNameArr{
            let homeVC = UIStoryboard.init(name: name, bundle: nil).instantiateInitialViewController()
            
            self.addChildViewController(homeVC!)
        }
        
    }

}
