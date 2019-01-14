//
//  HomeViewController.swift
//  DouYu
//
//  Created by zc on 2017/4/3.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

//232
//12312

private let kPageTitleH: CGFloat = 44.0

class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleView: PageTitleView = {
        let titles = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleH)
        
        let titleView = PageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        
        return titleView
    }()
    
    fileprivate lazy var pageContentView: PageContentView = {
        let pageH = kScreenH - kStatusBarH - kNavigationBarH - kPageTitleH - kTabBarH
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kPageTitleH, width: kScreenW, height: pageH)
        
        var childVCs = [UIViewController]()
        
        let recommendVC = RecommendViewController()
        childVCs.append(recommendVC)
        
        for _ in 0...3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVCs.append(vc)
            
        }
        
        let pageContentView = PageContentView(frame: frame, childVCs: childVCs)
        pageContentView.delegate = self
        
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
        
    }
    
}


//MARK:- 设置UI
extension HomeViewController{
    fileprivate func setupUI(){
    
        setupNavigationBar()
        
        self.view.addSubview(pageTitleView)
        
        self.view.addSubview(pageContentView)
    }
    
    private func setupContentView(){
        
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


//MARK:- PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate{
    func pageTitleViewClicked(titleView: PageTitleView, index: Int) {
        pageContentView.scrollToPageItem(index: index)
    }
}

//MARK:- PageContentViewDelegate
extension HomeViewController: PageContentViewDelegate{
    func pageContentView(_ pageContentView: PageContentView, sourceItem: Int, targetItem: Int, process: CGFloat) {
        pageTitleView.pageTitleView(fromIndex: sourceItem, toIndex: targetItem, process: process)
    }
}
