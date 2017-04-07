//
//  PageTitleView.swift
//  DouYu
//
//  Created by zc on 2017/4/4.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

private let kLineH: CGFloat = 0.5

protocol PageTitleViewDelegate: class {
    func pageTitleViewClicked(titleView: PageTitleView, index: Int)
}

class PageTitleView: UIView {
    
    fileprivate var titles: [String]
    fileprivate var selectLabel: UILabel?
    fileprivate lazy var titleLabels = [UILabel]()
    
    weak var delegate: PageTitleViewDelegate?
    
    //MARK:- 懒加载scrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    //MARK:- 滑块
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
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
        
        setupTitleLabels()
        setupBottomLine()
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
            label.tag = index
            
            //添加手势
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelTab(tabGes:)))
            label.addGestureRecognizer(tapGesture)
            
            self.titleLabels.append(label)
            self.scrollView.addSubview(label)
        }
    }
    
    @objc  func titleLabelTab(tabGes: UITapGestureRecognizer){
        guard let label = tabGes.view as? UILabel else{return}
        
        if label == selectLabel {
            return
        }
        
        selectLabel?.textColor = UIColor.darkGray
        label.textColor = UIColor.orange
        selectLabel = label
        
        UIView.animate(withDuration: 0.25) {
            self.scrollLine.center.x = label.center.x
        }
        
        delegate?.pageTitleViewClicked(titleView: self, index: label.tag)
    }
    
    private func setupBottomLine(){
        //底部横线
        let lineView = UIView(frame: CGRect(x: 0, y: scrollView.bounds.height, width: bounds.width, height: kLineH))
        lineView.backgroundColor = UIColor.lightGray
        
        self.addSubview(lineView)
        
        let scrollLineH: CGFloat = 4
        let scrollLineW: CGFloat = frame.width / CGFloat(titles.count) *  (3 / 4)
        let firstLabel = self.titleLabels[0]
        firstLabel.textColor = UIColor.orange
        self.selectLabel = firstLabel
        
        scrollLine.frame = CGRect(x: 0, y: frame.height - scrollLineH, width: scrollLineW, height: scrollLineH)
        scrollLine.center.x = firstLabel.center.x
        scrollView.addSubview(scrollLine)
    }
}

//MARK:- 外部方法
extension PageTitleView{
    func pageTitleView(fromIndex: Int, toIndex: Int, process: CGFloat) {
        
        let fromLabel = titleLabels[fromIndex]
        let targetLabel = titleLabels[toIndex]
        
        self.scrollLine.center.x = fromLabel.center.x + fromLabel.frame.width * process
        
    }
}


