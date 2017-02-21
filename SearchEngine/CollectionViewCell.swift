//
//  CollectionViewCell.swift
//  SearchEngine
//
//  Created by Appinventiv on 21/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // OUTLETS
    
 @IBOutlet weak var imageInCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
 // SETTING UP THE FLOW LAYOUT OF THE CELLS

class FlowLayout : UICollectionViewFlowLayout
    
{
    let itemHeight: CGFloat = 150
    
    override init()
    {
        super.init()
        setUpLayout()
    }
    func itemWidth() -> CGFloat
    {
        return ( collectionView!.frame.width)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // SETTING THE LAYOOT OF THE CELLS AMONG THEMSELVES
    
    func setUpLayout()
    {
        minimumInteritemSpacing = 3
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    // OVERRIDING THE FETCHED CELL'S SIZE
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width:itemWidth(), height: itemHeight)
        }
        get {
            return CGSize(width:itemWidth(), height: itemHeight)
        }
    }
    
}

