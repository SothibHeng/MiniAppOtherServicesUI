//
//  OtherServicesCellView.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class OtherServicesCellView: UICollectionViewCell {
    static let identifier = "OtherServicesCellView"

    fileprivate let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .cyan

        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),

            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16)
        ])
    }

    func configure(service: ServiceModel) {
        logoImageView.image = UIImage(named: service.logo)
        titleLabel.text = service.name
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

