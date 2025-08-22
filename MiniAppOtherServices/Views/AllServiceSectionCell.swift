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

    private let sectionBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    private var services: [ServiceModel] = []
    private var cellType: ServiceCellType = .vertical
    private var shouldRoundTopOnly = false

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .gray
        contentView.backgroundColor = .yellow

        contentView.addSubview(sectionBackground)
        sectionBackground.addSubview(titleLabel)
        sectionBackground.addSubview(itemsCollectionView)

        NSLayoutConstraint.activate([
            sectionBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            sectionBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sectionBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sectionBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: sectionBackground.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: sectionBackground.leadingAnchor, constant: 16),

            itemsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            itemsCollectionView.leadingAnchor.constraint(equalTo: sectionBackground.leadingAnchor, constant: 16),
            itemsCollectionView.trailingAnchor.constraint(equalTo: sectionBackground.trailingAnchor, constant: -16),
            itemsCollectionView.bottomAnchor.constraint(equalTo: sectionBackground.bottomAnchor, constant: -16),
        ])

        itemsCollectionView.backgroundColor = .green
        itemsCollectionView.register(OtherServicesCell.self, forCellWithReuseIdentifier: OtherServicesCell.identifier)
        itemsCollectionView.register(HorizontalOtherServicesCell.self, forCellWithReuseIdentifier: HorizontalOtherServicesCell.identifier)
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
    }
    
    func configure(title: String, services: [ServiceModel], cellType: ServiceCellType) {
            self.titleLabel.text = title
            self.services = services
            self.cellType = cellType
            self.shouldRoundTopOnly = (title == "Recently")
            itemsCollectionView.reloadData()

            if let flow = itemsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flow.scrollDirection = (cellType == .horizontal) ? .horizontal : .vertical
            }

            setNeedsLayout()
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











