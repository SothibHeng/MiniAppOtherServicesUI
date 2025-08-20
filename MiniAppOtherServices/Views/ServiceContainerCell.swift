//
//  ServiceContainerCell.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class ServicesContainerCell: UICollectionViewCell {
    static let identifier = "ServicesContainerCell"

    var onSelectService: ((ServiceModel) -> Void)?

    fileprivate var data: [ServiceModel] = []

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OtherServicesCell.self, forCellWithReuseIdentifier: OtherServicesCell.identifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .green
        
        contentView.addSubview(collectionView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds.insetBy(dx: 12, dy: 0)
    }

    func configure(with services: [ServiceModel]) {
        self.data = services
        collectionView.reloadData()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension ServicesContainerCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { data.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherServicesCell.identifier, for: indexPath) as! OtherServicesCell
        cell.configure(service: data[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelectService?(data[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView, layout layoutObj: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.bounds.height) // 80x~80 item
    }
}
