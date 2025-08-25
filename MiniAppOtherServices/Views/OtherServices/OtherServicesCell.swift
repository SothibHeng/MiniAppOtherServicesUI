//
//  OtherServicesCellView.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class OtherServicesCell: UICollectionViewCell {
    static let identifier = "OtherServicesCellView"

    fileprivate let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()

    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .cyan

        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        
        logoImageView.backgroundColor = .red
        nameLabel.backgroundColor = .red

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 74),
            logoImageView.heightAnchor.constraint(equalToConstant: 74),

            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4),
            nameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16)
        ])
    }

    func configure(service: ServiceModel) {
        logoImageView.image = UIImage(named: service.logo)
        nameLabel.text = service.name
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

