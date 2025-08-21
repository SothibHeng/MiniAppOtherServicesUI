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

class AllServiceSectionCell: UICollectionViewCell {
    
    static let identifier = "AllServiceSectionCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    private let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var services: [ServiceModel] = []
    private var cellType: ServiceCellType = .vertical
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green        
        contentView.addSubview(titleLabel)
        contentView.addSubview(itemsCollectionView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),

            itemsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            itemsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            itemsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            itemsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])

        
        itemsCollectionView.backgroundColor = .red
        itemsCollectionView.register(OtherServicesCell.self, forCellWithReuseIdentifier: OtherServicesCell.identifier)
        itemsCollectionView.register(HorizontalOtherServicesCell.self, forCellWithReuseIdentifier: HorizontalOtherServicesCell.identifier)
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
    }
    
    func configure(title: String, services: [ServiceModel], cellType: ServiceCellType) {
        self.titleLabel.text = title
        self.services = services
        self.cellType = cellType
        itemsCollectionView.reloadData()
        
        if cellType == .horizontal {
            (itemsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
        } else {
            (itemsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .vertical
        }
    }

    
    required init?(coder: NSCoder) { fatalError() }
}

extension AllServiceSectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let service = services[indexPath.item]
        switch cellType {
        case .vertical:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherServicesCell.identifier, for: indexPath) as! OtherServicesCell
            cell.configure(service: service)
            return cell
        case .horizontal:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalOtherServicesCell.identifier, for: indexPath) as! HorizontalOtherServicesCell
            cell.configure(service: service)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType {
        case .vertical:
            if services.count > 1 && titleLabel.text == "Recently" {
                let width = (collectionView.frame.width - 12 * 3) / 3
                return CGSize(width: width, height: 100)
            } else {
                let width = collectionView.frame.width
                return CGSize(width: width, height: 100)
            }
        case .horizontal:
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
}











