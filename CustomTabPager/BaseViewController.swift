//
//  BaseViewController.swift
//  CustomSideMenuBar
//
//  Created by Yuta S. on 2019/05/25.
//  Copyright © 2019 Yuta S. All rights reserved.
//
//


import UIKit

/// ベース画面
class BaseViewController: UIViewController {
    
    @IBOutlet weak var menuTabCollectionView: UICollectionView! {
        didSet {
            self.menuTabCollectionView.delegate = self
            self.menuTabCollectionView.dataSource = self
        }
    }
    let menuItems = ["項目1", "項目2", "項目3"]
    let isNewItemFrgList = [true, false, true]
    
    lazy var pageViewController: BasePageViewController = {
        return self.children[0] as! BasePageViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func selectTab(index: Int) {
        self.menuTabCollectionView.scrollToItem(at: [0, index], at: .right, animated: true)
        let cell = menuTabCollectionView.cellForItem(at: [0, index]) as! MenuTabCollectionViewCell
        cell.baceView.backgroundColor = .white
    }
    
    func deselectTab(index: Int) {
        let cell = menuTabCollectionView.cellForItem(at: [0, index]) as! MenuTabCollectionViewCell
        cell.baceView.backgroundColor = .clear
    }
}

extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath) as! MenuTabCollectionViewCell
        cell.nameLebel.text = self.menuItems[indexPath.row]
        cell.baceView.backgroundColor = indexPath.row == self.pageViewController.currentPage ? .white : .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        self.deselectTab(index: indexPath.row)
        self.selectTab(index: indexPath.row)
        self.pageViewController.setCurentViewController(index: indexPath.row)
    }
}
