//
//  RecommendViewController.swift
//  DouYu
//
//  Created by zc on 2017/4/9.
//  Copyright © 2017年 zc. All rights reserved.
//

import UIKit

private let kCollectionCell = "CollectionCell"
private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 44)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.red
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = self.view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionCell)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(self.view.bounds)
        setupUI()
    
    }
    
}

extension RecommendViewController{
    func setupUI(){
        
        
        self.view.addSubview(collectionView)
    }
}

//MARK:- collectionView delagete, datasource
extension RecommendViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 10
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kCollectionCell, for: indexPath)
        cell.backgroundColor = UIColor.green
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let kItemW = (self.view.bounds.width - 3) / 2
        let kitemH = kItemW * 3/4
        return CGSize(width: kItemW, height: kitemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID, for: indexPath)
        headerView.backgroundColor = UIColor.orange
        
        return headerView
    }
}
