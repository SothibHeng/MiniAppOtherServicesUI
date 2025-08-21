//
//  AllServiceCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

import UIKit

class AllServiceSectionContainerCell: UICollectionViewCell {

    static let identifier = "AllServiceSectionContainerCell"
    
    private let sectionContainerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 40)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        contentView.addSubview(sectionContainerCollectionView)
        sectionContainerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sectionContainerCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionContainerCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sectionContainerCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sectionContainerCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        sectionContainerCollectionView.backgroundColor = .green
        
        sectionContainerCollectionView.register(OtherServicesCell.self,
                                     forCellWithReuseIdentifier: OtherServicesCell.identifier)
        sectionContainerCollectionView.register(ExploreContainerCell.self,
                                     forCellWithReuseIdentifier: ExploreContainerCell.identifier)
        sectionContainerCollectionView.register(AllServiceWrapperCell.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: AllServiceWrapperCell.identifier)
        
        sectionContainerCollectionView.dataSource = self
        sectionContainerCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


extension AllServiceSectionContainerCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 3 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OtherServicesCell.identifier,
                for: indexPath
            ) as! OtherServicesCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ExploreContainerCell.identifier,
                for: indexPath
            ) as! ExploreContainerCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let totalSpacing: CGFloat = 12 * 2
            let interItemSpacing: CGFloat = 12 * 2
            let width = (collectionView.frame.width - totalSpacing - interItemSpacing) / 3
            return CGSize(width: width, height: 100)
        } else {
            let width = collectionView.frame.width - 24
            return CGSize(width: width, height: 80)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: AllServiceWrapperCell.identifier,
            for: indexPath
        ) as! AllServiceWrapperCell
        header.titleLabel.text = indexPath.section == 0 ? "Recently" : "Explore"
        return header
    }
}






