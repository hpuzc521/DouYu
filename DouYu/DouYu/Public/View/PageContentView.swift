//
//  PageContentView.swift
//  DouYu
//
//  Created by zc on 2017/4/5.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

private let kCellIdentifier = "CellIdentifier"

protocol PageContentViewDelegate: class{
    func pageContentView(_ pageContentView: PageContentView, sourceItem: Int, targetItem: Int, process: CGFloat);
}

class PageContentView: UIView {
    
    fileprivate let childVCs: [UIViewController]
    
    fileprivate var oldOffsetX: CGFloat = 0
    
    fileprivate var isScroll: Bool = false
    
    weak var delegate: PageContentViewDelegate?
    
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = self!.bounds.size
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellIdentifier)
        
        return collectionView
    }()

    init(frame: CGRect, childVCs: [UIViewController]) {
        self.childVCs = childVCs
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollToPageItem(index: Int){
        isScroll = false
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }

}


extension PageContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate{
    
    fileprivate func setupUI(){
        
        collectionView.frame = bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        self.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return childVCs.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellIdentifier, for: indexPath)
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return bounds.size
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isScroll = true
        oldOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        
        if !isScroll { return }
        
        var process: CGFloat = 0
        var sourcePage:Int = 0
        var targetPage:Int = 0
        let offset: CGFloat = scrollView.contentOffset.x.truncatingRemainder(dividingBy: bounds.width)
        
        if scrollView.contentOffset.x > oldOffsetX {
            sourcePage = Int(scrollView.contentOffset.x / bounds.width)
            targetPage = sourcePage + 1 > childVCs.count - 1 ? childVCs.count - 1 : sourcePage + 1
            process = offset / bounds.width
            if scrollView.contentOffset.x - oldOffsetX == bounds.width {
                targetPage = sourcePage
                process = 1
            }
        }else if scrollView.contentOffset.x < oldOffsetX{
            targetPage = Int(scrollView.contentOffset.x / bounds.width)
            sourcePage = targetPage + 1
            process = offset / bounds.width - 1
            if oldOffsetX - scrollView.contentOffset.x == bounds.width {
                sourcePage = targetPage
                process = 1
            }
        }
        
        print("source: \(sourcePage) target: \(targetPage) process: \(process)")

        delegate?.pageContentView(self, sourceItem: sourcePage, targetItem: targetPage, process: process)
    }
    
    
    
}




