//
//  HorizontalOtherServicesCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 21/8/25.
//

import UIKit

class HorizontalOtherServicesCell: UICollectionViewCell {
    static let identifier = "HorizontalOtherServicesCell"

    fileprivate let logoContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightBorder.cgColor
        return view
    }()

    fileprivate let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    fileprivate let nameLabel: MarqueeLabel = {
        let label = MarqueeLabel(frame: .zero, duration: 16.0, fadeLength: 10.0)
        label.font = .systemFont(ofSize: 16.5, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.type = .continuous
        label.leadingBuffer = 5
        label.trailingBuffer = 5
        return label
    }()
    
    fileprivate var imageWidthConstraint: NSLayoutConstraint?
    fileprivate var imageHeightConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupShadow()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    fileprivate func setupLayout() {
        contentView.addSubview(logoContainer)
        logoContainer.addSubview(logoImageView)
        contentView.addSubview(nameLabel)

        logoContainer.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        imageWidthConstraint = logoImageView.widthAnchor.constraint(equalToConstant: 1)
        imageHeightConstraint = logoImageView.heightAnchor.constraint(equalToConstant: 1)
        imageWidthConstraint?.isActive = true
        imageHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            logoContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            logoContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoContainer.widthAnchor.constraint(equalToConstant: 74),
            logoContainer.heightAnchor.constraint(equalToConstant: 74),

            logoImageView.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: logoContainer.centerYAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: logoContainer.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    fileprivate func setupShadow() {
        layer.cornerRadius = 16
        layer.shadowColor = UIColor.subtitleColor.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        backgroundColor = .white
    }

    func configure(service: ServiceModel) {
        logoImageView.image = UIImage(named: service.logo)
        nameLabel.text = service.name
        logoContainer.backgroundColor = service.backgroundColor

        imageWidthConstraint?.constant = service.logoSize.width
        imageHeightConstraint?.constant = service.logoSize.height

        layoutIfNeeded()
    }

}

