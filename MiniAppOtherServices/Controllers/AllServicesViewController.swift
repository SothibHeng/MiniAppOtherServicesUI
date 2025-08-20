//
//  ViewAllServicesViewController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

class AllServicesViewController: UIViewController {
    
    fileprivate let titlelabel: UILabel = {
        let label = UILabel()
        label.text = "Other Servies"
        label.textColor = .titleColor
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "With partner"
        label.textColor = .subtitleColor
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "handshake")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        view.backgroundColor = .cyan
        title = "All Services"
        
        setupHeader()
    }
    
    fileprivate func setupHeader() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        let verticalStack = UIStackView(arrangedSubviews: [titlelabel, subtitleLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.alignment = .leading
        
        let horizontalStack = UIStackView(arrangedSubviews: [verticalStack, imageView])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 16
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        
        view.addSubview(horizontalStack)
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            horizontalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            horizontalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            horizontalStack.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
}

