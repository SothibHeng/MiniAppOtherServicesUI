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
        view.backgroundColor = .systemBackground
        setupCollectionView()
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
        
        collectionView.backgroundColor = .systemBackground
        
        collectionView.register(AllServicesHeaderCell.self,
                                forCellWithReuseIdentifier: AllServicesHeaderCell.identifier)
        
        collectionView.register(AllServiceSectionCell.self,
                                forCellWithReuseIdentifier: AllServiceSectionCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}


extension AllServicesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        } else {
            return .zero
        }
    }

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
            return CGSize(width: collectionView.frame.width, height: 180)
        } else {
            let sectionData = sections[indexPath.section - 1]
            let titleHeight: CGFloat = 28
            let spacingAboveItems: CGFloat = 8
            let bottomPadding: CGFloat = 16
            let itemHeight: CGFloat = 120
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









