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
        layout.sectionInset = .zero
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var recentServices: [ServiceModel] = [
        ServiceModel(name: "BBC New", logo: "bbc-new", url: ""),
        ServiceModel(name: "BBC New", logo: "bbc-new", url: ""),
        ServiceModel(name: "BBC New", logo: "bbc-new", url: ""),

    ]
    
    private var exploreServices: [ServiceModel] = [
        ServiceModel(name: "Disney", logo: "disney", url: ""),
        ServiceModel(name: "Disney", logo: "disney", url: ""),
        ServiceModel(name: "Disney", logo: "disney", url: ""),
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
        collectionView.register(AllServiceSectionContainerCell.self,
                                forCellWithReuseIdentifier: AllServiceSectionContainerCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension AllServicesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 1 }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AllServicesHeaderCell.identifier,
                for: indexPath
            ) as! AllServicesHeaderCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AllServiceSectionContainerCell.identifier,
                for: indexPath
            ) as! AllServiceSectionContainerCell
            
            let sections = [
                ServiceSection(title: "Recently",
                               services: recentServices,
                               cellType: .vertical),
                ServiceSection(title: "Explore",
                               services: exploreServices,
                               cellType: .horizontal)
            ]
            
            cell.configure(with: sections)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 180)
        } else {
            
            return CGSize(width: view.frame.width, height: view.frame.height)
        }
    }
}





