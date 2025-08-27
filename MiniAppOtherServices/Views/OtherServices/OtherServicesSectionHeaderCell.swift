//
//  OtherServicesSectionHeaderCellView.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class OtherServicesSectionHeaderCell: UICollectionReusableView {
    static let identifier = "SectionHeaderView"

    var onTap: (() -> Void)?   
    
    fileprivate let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        if let image = UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate) {
                imageView.image = image
            }
        imageView.tintColor = .primary
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
    }
    
    fileprivate func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, arrowImageView])
        addSubview(stackView)
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }

    @objc private func didTap() {
        onTap?()
    }

    func configure(title: String, titleColor: UIColor = .primary) {
        titleLabel.text = title
        titleLabel.textColor = titleColor
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
