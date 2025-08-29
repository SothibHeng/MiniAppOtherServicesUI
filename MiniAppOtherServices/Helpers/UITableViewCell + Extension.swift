//
//  UITableViewCell + Extension.swift
//  MiniAppOtherServices
//
//  Created by Universe on 27/8/25.
//

import UIKit

public extension UITableViewCell {

    static var reusableIdentifier: String {
        return "\(self)"
    }

    static func nib() -> UINib {
        return UINib(nibName: self.reusableIdentifier, bundle: Bundle(for: self))
    }
}

public extension UITableView {
    
    func register(_ cellType: UITableViewCell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reusableIdentifier)
    }
    
    func registerNib(of cellType: UITableViewCell.Type) {
        register(cellType.nib(), forCellReuseIdentifier: cellType.reusableIdentifier)
    }
    
    func dequeue<Cell>(_ cellType: Cell.Type, for indexPath: IndexPath) -> Cell where Cell : UITableViewCell {
        return dequeueReusableCell(withIdentifier: cellType.reusableIdentifier, for: indexPath) as! Cell
    }

}
