//
//  BannerCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class BannerCell: UICollectionViewCell {
    static let identifier = "BannerCellView"

    fileprivate let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    fileprivate var widthConstraint: NSLayoutConstraint?
    private var heightContraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])

        widthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 100)
        heightContraint = logoImageView.heightAnchor.constraint(equalToConstant: 100)
        widthConstraint?.isActive = true
        heightContraint?.isActive = true
    }

    func configure(with model: BannerModel) {
        contentView.backgroundColor = model.backgroundColor
        logoImageView.image = model.imageName
        widthConstraint?.constant = model.size.width
        heightContraint?.constant = model.size.height
        layoutIfNeeded()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
