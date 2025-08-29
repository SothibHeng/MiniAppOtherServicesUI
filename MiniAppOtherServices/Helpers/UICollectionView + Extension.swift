//
//  UICollectionView + Extension.swift
//  MiniAppOtherServices
//
//  Created by Universe on 27/8/25.
//

import Foundation
import UIKit

public extension UICollectionViewCell {
    
    static var reusableIdentifier: String {
        return "\(self)"
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.reusableIdentifier, bundle: Bundle(for: self))
    }
}

public extension UICollectionView {

    func register(_ cellType: UICollectionViewCell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reusableIdentifier)
    }

    func registerNib(of cellType: UICollectionViewCell.Type) {
        register(cellType.nib(), forCellWithReuseIdentifier: cellType.reusableIdentifier)
    }

    func dequeue<Cell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell where Cell : UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: cellType.reusableIdentifier, for: indexPath) as! Cell
    }

}
