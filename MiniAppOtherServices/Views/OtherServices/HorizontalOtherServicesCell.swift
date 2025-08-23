//
//  HorizontalOtherServicesCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 21/8/25.
//

import UIKit

class HorizontalOtherServicesCell: UICollectionViewCell {
    static let identifier = "HorizontalOtherServicesCell"

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
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .cyan
        layer.cornerRadius = 16

        contentView.addSubview(logoImageView)
        contentView.addSubview(nameLabel)
        
        logoImageView.backgroundColor = .red

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 60),
            logoImageView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(service: ServiceModel) {
        logoImageView.image = UIImage(named: service.logo)
        nameLabel.text = service.name
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
