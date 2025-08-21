//
//  AnotherInnerCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

class ExploreContainerCell: UICollectionViewCell {
    static let identifier = "AnotherInnerCell"
    
    private let otherCell = OtherServicesCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        
        contentView.addSubview(otherCell)
        otherCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            otherCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            otherCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            otherCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            otherCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




