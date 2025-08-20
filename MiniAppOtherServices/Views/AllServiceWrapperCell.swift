//
//  AllServiceCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

class AllServiceWrapperCell: UICollectionViewCell {
    static let identifier = "AllServiceWrapperCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .cyan
        
        let label = UILabel()
        label.text = "Wrapper Cell"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}



