//
//  ViewAllServicesViewController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

class AllServicesViewController: UIViewController {

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = .zero
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    fileprivate var recentServices: [ServiceModel] = [
        ServiceModel(serviceType: .bbc),
        ServiceModel(serviceType: .duolingo),
        ServiceModel(serviceType: .imdb)
    ]
    
    fileprivate var exploreServices: [ServiceModel] = [
        ServiceModel(serviceType: .bbc),
        ServiceModel(serviceType: .duolingo),
        ServiceModel(serviceType: .imdb),
        ServiceModel(serviceType: .disney),
        ServiceModel(serviceType: .coursera),
        ServiceModel(serviceType: .khanAcademy),
        ServiceModel(serviceType: .twitch),
        ServiceModel(serviceType: .etsy),
        ServiceModel(serviceType: .reuters),
        ServiceModel(serviceType: .aliExpress)
    ]
    
    fileprivate lazy var sections: [ServiceSection] = [
        ServiceSection(title: "Recently", services: recentServices, cellType: .vertical),
        ServiceSection(title: "Explore", services: exploreServices, cellType: .horizontal)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        collectionView.showsVerticalScrollIndicator = false
        setupCollectionView()
        
        setupCustomNavigationBar()
    }

    fileprivate func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.backgroundColor = .background
        
        collectionView.register(AllServicesHeaderCell.self,
                                forCellWithReuseIdentifier: AllServicesHeaderCell.identifier)
        
        collectionView.register(AllServiceSectionCell.self,
                                forCellWithReuseIdentifier: AllServiceSectionCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    fileprivate func setupCustomNavigationBar() {
        let backButton = UIButton(type: .system)
        let backImage = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        backButton.setImage(backImage, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 18),
            backButton.heightAnchor.constraint(equalToConstant: 18)
        ])

        let titleLabel = UILabel()
        titleLabel.text = "Other Services"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = .white

        let leftStack = UIStackView(arrangedSubviews: [backButton, titleLabel])
        leftStack.axis = .horizontal
        leftStack.spacing = 8
        leftStack.alignment = .center

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftStack)

        let logoImageView = UIImageView(image: UIImage(named: "acleda_logo"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoImageView)

        if let navBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.primary
            appearance.shadowColor = .clear
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
            navBar.tintColor = .white
        }
    }

    @objc fileprivate func didTapBack() {
        navigationController?.popViewController(animated: true)
    }

}

extension AllServicesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 + sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    fileprivate func showService(_ service: ServiceModel) {
        let webController = WebViewController(service: service)
        navigationController?.pushViewController(webController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AllServicesHeaderCell.identifier,
                for: indexPath
            ) as! AllServicesHeaderCell
            return cell
        } else {
            let sectionData = sections[indexPath.section - 1]
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AllServiceSectionCell.identifier,
                for: indexPath
            ) as! AllServiceSectionCell
            cell.configure(title: sectionData.title,
                           services: sectionData.services,
                           cellType: sectionData.cellType)
            cell.onSelectService = { [weak self] service in
                self?.showService(service)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 195)
        } else {
            let sectionData = sections[indexPath.section - 1]
            let titleHeight: CGFloat = 28
            let spacingAboveItems: CGFloat = 8
            let bottomPadding: CGFloat = 16
            let itemHeight: CGFloat = 80
            let spacingBetweenItems: CGFloat = 12

            switch sectionData.cellType {
            case .vertical:
                let rows = ceil(CGFloat(sectionData.services.count) / 4.0)
                let cellHeight = CGFloat(rows) * itemHeight
                                 + CGFloat(rows - 1) * spacingBetweenItems
                                 + titleHeight + spacingAboveItems + bottomPadding
                return CGSize(width: collectionView.frame.width, height: cellHeight + 80)

            case .horizontal:
                let totalHeight = titleHeight
                                  + spacingAboveItems
                                  + CGFloat(sectionData.services.count) * itemHeight
                                  + CGFloat(sectionData.services.count - 1) * spacingBetweenItems
                                  + bottomPadding
                return CGSize(width: collectionView.frame.width, height: totalHeight)
            }
        }
    }
}









