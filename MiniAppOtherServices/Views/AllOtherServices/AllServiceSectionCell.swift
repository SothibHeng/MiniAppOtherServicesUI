//
//  AllServiceCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

enum ServiceCellType {
    case vertical
    case horizontal
}

struct ServiceSection {
    let title: String
    let services: [ServiceModel]
    let cellType: ServiceCellType
}

final class AllServiceSectionCell: UICollectionViewCell {
    let sectionBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .titleColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 16
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        collectionView.register(OtherServicesCell.self)
        collectionView.register(HorizontalOtherServicesCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var shouldRoundTopOnly = false
    private var services: [ServiceModel] = []
    private var cellType: ServiceCellType = .vertical
    
    var onSelectService: ((ServiceModel) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        sectionBackground.layer.masksToBounds = true
        if shouldRoundTopOnly {
            sectionBackground.layer.cornerRadius = 16
            if #available(iOS 11.0, *) {
                sectionBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else {
                let path = UIBezierPath(roundedRect: sectionBackground.bounds,
                                        byRoundingCorners: [.topLeft, .topRight],
                                        cornerRadii: CGSize(width: 16, height: 16))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                sectionBackground.layer.mask = mask
            }
        } else {
            sectionBackground.layer.cornerRadius = 0
            sectionBackground.layer.maskedCorners = []
            sectionBackground.layer.mask = nil
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        shouldRoundTopOnly = false
        sectionBackground.layer.cornerRadius = 0
        sectionBackground.layer.maskedCorners = []
        sectionBackground.layer.mask = nil
    }

    required init?(coder: NSCoder) { fatalError() }
}

extension AllServiceSectionCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedService = services[indexPath.item]
        onSelectService?(selectedService)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let service = services[indexPath.item]
        switch cellType {
        case .vertical:
            let cell = collectionView.dequeue(OtherServicesCell.self, for: indexPath)
            cell.configure(service: service)
            
            return cell
            
        case .horizontal:
            let cell = collectionView.dequeue(HorizontalOtherServicesCell.self, for: indexPath)
            cell.configure(service: service)
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType {
        case .vertical:
            let width = collectionView.frame.width / 3 - 8
            return CGSize(width: width, height: 120)
        case .horizontal:
            let width = collectionView.frame.width
            return CGSize(width: width, height: 100)
        }
    }
}

extension AllServiceSectionCell {
    func setupViews() {
        backgroundColor = .primary
        
        contentView.addSubview(sectionBackground)
        sectionBackground.addSubview(titleLabel)
        sectionBackground.addSubview(itemsCollectionView)
        
        NSLayoutConstraint.activate([
            sectionBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sectionBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sectionBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: sectionBackground.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: sectionBackground.leadingAnchor, constant: 16),
            
            itemsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            itemsCollectionView.bottomAnchor.constraint(equalTo: sectionBackground.bottomAnchor, constant: -16),
            itemsCollectionView.leadingAnchor.constraint(equalTo: sectionBackground.leadingAnchor, constant: 16),
            itemsCollectionView.trailingAnchor.constraint(equalTo: sectionBackground.trailingAnchor, constant: -16),
        ])
    }
    
    func configure(title: String, services: [ServiceModel], cellType: ServiceCellType) {
        self.titleLabel.text = title
        self.services = services
        self.cellType = cellType
        self.shouldRoundTopOnly = (title == "Recently")
        itemsCollectionView.reloadData()
        
        if title == "Recently" {
            itemsCollectionView.backgroundColor = .white
            itemsCollectionView.layer.shadowColor = UIColor.subtitleColor.cgColor
            itemsCollectionView.layer.shadowOpacity = 0.1
            itemsCollectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
            itemsCollectionView.layer.shadowRadius = 4
            itemsCollectionView.layer.masksToBounds = false
        } else {
            itemsCollectionView.backgroundColor = .clear
        }
        
        if let flow = itemsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.scrollDirection = (cellType == .horizontal) ? .vertical : .vertical
            flow.minimumLineSpacing = 12
            flow.minimumInteritemSpacing = 0
        }
        
        if title == "Recently" {
            itemsCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        } else {
            itemsCollectionView.contentInset = .zero
        }
        
        setNeedsLayout()
    }
}
