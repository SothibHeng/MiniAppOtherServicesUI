//
//  AllServiceCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

enum ServiceCellType {
    case vertical
    case horizontal
}

struct ServiceSection {
    let title: String
    let services: [ServiceModel]
    let cellType: ServiceCellType
}

import UIKit

class AllServiceSectionContainerCell: UICollectionViewCell {
    
    static let identifier = "AllServiceSectionContainerCell"
    
    private var sections: [ServiceSection] = []

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
        sectionContainerCollectionView.register(HorizontalOtherServicesCell.self,
                                                forCellWithReuseIdentifier: HorizontalOtherServicesCell.identifier)
        sectionContainerCollectionView.register(AllServiceWrapperCell.self,
                                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                withReuseIdentifier: AllServiceWrapperCell.identifier)
        
        sectionContainerCollectionView.dataSource = self
        sectionContainerCollectionView.delegate = self
    }
    
    func configure(with sections: [ServiceSection]) {
        self.sections = sections
        sectionContainerCollectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AllServiceSectionContainerCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].services.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        let service = section.services[indexPath.item]
        
        switch section.cellType {
        case .vertical:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: OtherServicesCell.identifier,
                for: indexPath
            ) as! OtherServicesCell
            cell.configure(service: service)
            cell.backgroundColor = .white
            return cell
            
        case .horizontal:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HorizontalOtherServicesCell.identifier,
                for: indexPath
            ) as! HorizontalOtherServicesCell
            cell.configure(service: service)
            cell.backgroundColor = .cyan
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = sections[indexPath.section]
        
        switch section.cellType {
        case .vertical:
            let totalSpacing: CGFloat = 12 * 2
            let interItemSpacing: CGFloat = 12 * 2
            let width = (collectionView.frame.width - totalSpacing - interItemSpacing) / 3
            return CGSize(width: width, height: 100)
            
        case .horizontal:
            let width = collectionView.frame.width - 24
            return CGSize(width: width, height: 100)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: AllServiceWrapperCell.identifier,
            for: indexPath
        ) as! AllServiceWrapperCell
        header.titleLabel.text = section.title
        return header
    }
}







