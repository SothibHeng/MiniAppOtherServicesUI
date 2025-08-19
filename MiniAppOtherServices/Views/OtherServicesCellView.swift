//
//  OtherServicesCellView.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class OtherServicesCellView: UICollectionViewCell {
    static let identifier = "ServiceCell"
    
    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
    
        iconView.widthAnchor.constraint(equalToConstant: 08).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.frame = CGRect(x: (contentView.frame.size.width - 50) / 2, y: 5, width: 50, height: 50)
        titleLabel.frame = CGRect(x: 0, y: 60, width: contentView.frame.size.width, height: 20)
    }
    
    func configure(service: ServiceModel) {
        iconView.image = UIImage(named: service.icon)
        titleLabel.text = service.name
    }
}
