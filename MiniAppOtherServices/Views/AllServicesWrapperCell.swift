//
//  AllServicesWrapperCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 21/8/25.
//

import UIKit

class AllServicesWrapperCell: UICollectionViewCell {
    
    static let identifier = "AllServicesWrapperCell"
    
    fileprivate let wrapperCell = AllServiceSectionCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        
        contentView.addSubview(wrapperCell)
        wrapperCell.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            wrapperCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            wrapperCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wrapperCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            wrapperCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(title: String, services: [ServiceModel], cellType: ServiceCellType) {
        wrapperCell.configure(title: title, services: services, cellType: cellType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

