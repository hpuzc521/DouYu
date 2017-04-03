//
//  HomeViewController.swift
//  DouYu
//
//  Created by zc on 2017/4/3.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
}


//MARK:- 设置UI
extension HomeViewController{
    fileprivate func setupUI(){
    
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 254.0/255.0, green: 151.0/255.0, blue: 42.0/255.0, alpha: 1);
        
        //方法一
        //        let logoImg = UIImage.init(named: "homeLogoIcon")?.withRenderingMode(.alwaysOriginal)
        //
        //        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: logoImg, style: .plain, target: self, action: nil)
        
        //方法二
        let leftBtn = UIButton()
        leftBtn.setImage(UIImage.init(named: "homeLogoIcon"), for: .normal)
        leftBtn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        let btnSize = CGSize(width: 35, height: 25)
        
        let historyItem = creatNavigationItem(imageName: "viewHistoryIcon", size: btnSize)
        let gameItem = creatNavigationItem(imageName: "home_newGameicon", size: btnSize)
        
        navigationItem.rightBarButtonItems = [historyItem, gameItem]
    }
    
    private func creatNavigationItem(imageName: String, size: CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        let barButtonItem = UIBarButtonItem(customView: btn)
        
        return barButtonItem
    }
}
