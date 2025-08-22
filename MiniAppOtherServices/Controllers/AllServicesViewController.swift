//
//  ViewAllServicesViewController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

class AllServicesViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = .zero
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var recentServices: [ServiceModel] = [
        ServiceModel(name: "BBC New", logo: "bbc-new", url: ""),
        ServiceModel(name: "BBC New", logo: "bbc-new", url: ""),
        ServiceModel(name: "BBC New", logo: "bbc-new", url: "")
    ]
    
    private var exploreServices: [ServiceModel] = [
        ServiceModel(name: "Disney", logo: "disney", url: ""),
        ServiceModel(name: "Disney", logo: "disney", url: ""),
        ServiceModel(name: "Disney", logo: "disney", url: "")
    ]
    
    private lazy var sections: [ServiceSection] = [
        ServiceSection(title: "Recently", services: recentServices, cellType: .vertical),
        ServiceSection(title: "Explore", services: exploreServices, cellType: .horizontal)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupCollectionView()
    }

    private func setupCollectionView() {
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
        
        collectionView.register(AllServiceSectionCell.self, forCellWithReuseIdentifier: AllServiceSectionCell.identifier)
        
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

            if indexPath.section == sections.count {
                let usedHeight: CGFloat = 180
                let remainingHeight = collectionView.bounds.height - usedHeight
                return CGSize(width: collectionView.frame.width, height: max(remainingHeight, 200))
            } else {
                switch sectionData.cellType {
                case .vertical:
                    let rows = ceil(CGFloat(sectionData.services.count) / 4.0)
                    let cellHeight = 100.0 * rows + 12.0 * (rows - 1) + 16 * 2
                    return CGSize(width: collectionView.frame.width, height: cellHeight + 40)
                case .horizontal:
                    return CGSize(width: collectionView.frame.width, height: view.frame.width)
                }
            }
        }
    }

}










