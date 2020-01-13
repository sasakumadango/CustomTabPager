//
//  MenuTabCollectionViewCell.swift
//  CustomSideMenuBar
//
//  Created by infocanaldev on 2019/11/28.
//  Copyright © 2019 Yuta.S. All rights reserved.
//

import UIKit

class MenuTabCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLebel: UILabel!
    
    @IBOutlet weak var baceView: UIView! {
        didSet {
            self.baceView.layer.cornerRadius = 15
            self.baceView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
}

