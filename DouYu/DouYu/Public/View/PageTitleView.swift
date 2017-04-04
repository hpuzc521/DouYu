//
//  PageTitleView.swift
//  DouYu
//
//  Created by zc on 2017/4/4.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

private let kLineH: CGFloat = 0.5

class PageTitleView: UIView {
    
    fileprivate var titles: [String]
    
    //MARK:- 懒加载scrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()

    //MARK:- 构造方法
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
    
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI
extension PageTitleView{
    
    fileprivate func setupUI(){
        
        self.addSubview(scrollView)
        scrollView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - kLineH)
        
        let lineView = UIView(frame: CGRect(x: 0, y: scrollView.bounds.height, width: bounds.width, height: kLineH))
        lineView.backgroundColor = UIColor.lightGray
        
        self.addSubview(lineView)
        
        setupTitleLabels()
    }
    
    private func setupTitleLabels(){
        let labelW = self.bounds.width / CGFloat(self.titles.count)
        let labelH = self.bounds.height
        
        for (index, title) in self.titles.enumerated(){
            let label = UILabel()
            label.frame = CGRect(x: CGFloat(index) * labelW, y: 0, width: labelW, height: labelH)
            
            label.text = title
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = NSTextAlignment.center
            
            self.scrollView.addSubview(label)
        }
    }
}
