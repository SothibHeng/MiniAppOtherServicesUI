//
//  AllServicesHeaderCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//


import UIKit

class AllServicesHeaderCell: UICollectionViewCell {
    
    static let identifier = "AllServicesHeaderCell"
    
    fileprivate let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Other Services"
        label.textColor = .sunYellow
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "with partner"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "handshake")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .primary
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        let verticalStack = UIStackView(arrangedSubviews: [titlelabel, subtitleLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 6
        verticalStack.alignment = .leading
        
        let horizontalStack = UIStackView(arrangedSubviews: [verticalStack, imageView])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 16
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        
        addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22),
            horizontalStack.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
