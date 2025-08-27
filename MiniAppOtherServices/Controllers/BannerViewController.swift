//
//  BannerViewController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 26/8/25.
//

import UIKit

class BannerViewController: UIViewController {
    private let banner: BannerModel
    private let imageView = UIImageView()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.hidesForSinglePage = true
        pc.currentPage = 0
        return pc
    }()
    
    init(banner: BannerModel) {
        self.banner = banner
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(pageControl)
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightBorder.cgColor
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(red: 237/255, green: 245/255, blue: 255/255, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.4)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = banner.imageName
        view.backgroundColor = banner.backgroundColor
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: banner.size.width),
            imageView.heightAnchor.constraint(equalToConstant: banner.size.height),
        ])
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
}
