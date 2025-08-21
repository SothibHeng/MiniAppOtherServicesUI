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

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .cyan

        contentView.addSubview(logoImageView)
        contentView.addSubview(titleLabel)
        
        logoImageView.backgroundColor = .red

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            logoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 60),
            logoImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(service: ServiceModel) {
        logoImageView.image = UIImage(named: service.logo)
        titleLabel.text = service.name
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
