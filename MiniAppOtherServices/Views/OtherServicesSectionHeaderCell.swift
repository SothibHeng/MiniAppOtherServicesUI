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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    fileprivate let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.textColor = .label
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

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

    func configure(title: String) { titleLabel.text = title }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


