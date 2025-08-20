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
        
//        imageView.backgroundColor = .red
        imageView.sizeSubView(size: CGSize(width: 140, height: 140))
        
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            titlelabel, subtitleLabel, UIView()
        ])
        
        verticalStackView.axis = .vertical
        
        let overallStackView = UIStackView(arrangedSubviews: [
            verticalStackView, imageView
        ])
        
        overallStackView.axis = .horizontal
        overallStackView.spacing = 10
        overallStackView.alignment = .center
        
//        overallStackView.backgroundColor = .cyan
        
        view.addSubview(overallStackView)
        overallStackView.anchors(top: view.safeAreaLayoutGuide.topAnchor, topConstant: 30, leading: view.leadingAnchor, leadingConstant: 22, trailing: view.trailingAnchor, trailingConstant: 22, bottom: nil)
        
        overallStackView.sizeSubView(size: CGSize(width: 0, height: 180))
    }
}

