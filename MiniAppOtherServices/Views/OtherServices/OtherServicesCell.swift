//
//  OtherServicesCellView.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class OtherServicesCell: UICollectionViewCell {
    static let identifier = "OtherServicesCellView"

    fileprivate let logoContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    fileprivate let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    fileprivate var imageWidthConstraint: NSLayoutConstraint?
    fileprivate var imageHeightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)
        contentView.addSubview(nameLabel)

        logoContainer.translatesAutoresizingMaskIntoConstraints = false
        logoContainer.layer.borderWidth = 1
        logoContainer.layer.borderColor = UIColor.lightBorder.cgColor
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            logoContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoContainer.widthAnchor.constraint(equalToConstant: 74),
            logoContainer.heightAnchor.constraint(equalToConstant: 74),

            logoImageView.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: logoContainer.centerYAnchor),

            nameLabel.topAnchor.constraint(equalTo: logoContainer.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16)
        ])

        imageWidthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 1)
        imageHeightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 1)
        imageWidthConstraint?.isActive = true
        imageHeightConstraint?.isActive = true
    }

    func configure(service: ServiceModel) {
        logoImageView.image = UIImage(named: service.logo)
        nameLabel.text = service.name
        logoContainer.backgroundColor = service.backgroundColor
        
        imageWidthConstraint?.constant = service.logoSize.width
        imageHeightConstraint?.constant = service.logoSize.height
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension OtherServicesCell {
    func viewAllButton(title: String = "View All", logoName: String = "viewAll") {
        nameLabel.text = title
        logoImageView.image = UIImage(named: logoName)
        logoContainer.backgroundColor = .white
        imageWidthConstraint?.constant = 30
        imageHeightConstraint?.constant = 30
    }
}
