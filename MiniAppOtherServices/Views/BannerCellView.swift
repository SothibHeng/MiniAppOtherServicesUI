//
//  BannerCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//


import UIKit

struct BannerModel {
    let image: UIImage
    let size: CGSize
}

class BannerCellView: UICollectionViewCell {
    static let identifier = "BannerCell"
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // Create but don’t lock sizes yet
        widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 100)
        heightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 100)
        widthConstraint?.isActive = true
        heightConstraint?.isActive = true
    }
    
    func configure(banner: BannerModel) {
        logoImageView.image = banner.image
        
        // Update size dynamically
        widthConstraint?.constant = banner.size.width
        heightConstraint?.constant = banner.size.height
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


