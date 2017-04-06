//
//  PageContentView.swift
//  DouYu
//
//  Created by zc on 2017/4/5.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

private let kCellIdentifier = "CellIdentifier"

class PageContentView: UIView {
    
    fileprivate let childVCs: [UIViewController]
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
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

}

extension PageContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
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
    
}




