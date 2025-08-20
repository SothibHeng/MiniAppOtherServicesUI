//
//  BannerContainerCellView.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//


import UIKit

class BannerContainerCell: UICollectionViewCell {
    static let identifier = "BannerContainerCell"

    fileprivate var data: [BannerModel] = []

    fileprivate let pageControl: UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.hidesForSinglePage = true
        return pageControll
    }()

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .blue
        backgroundColor = .whiteSmoke
        
        contentView.addSubview(collectionView)
        contentView.addSubview(pageControl)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height - 24)
        pageControl.frame = CGRect(x: 0, y: collectionView.frame.maxY, width: contentView.bounds.width, height: 24)
    }

    func configure(with banners: [BannerModel]) {
        self.data = banners
        pageControl.numberOfPages = banners.count
        pageControl.currentPage = 0
        collectionView.contentOffset = .zero
        collectionView.reloadData()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension BannerContainerCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { data.count }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as! BannerCell
        cell.configure(with: data[indexPath.item])
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width > 0 else { return }
        let page = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = max(0, min(page, pageControl.numberOfPages - 1))
    }

    func collectionView(_ collectionView: UICollectionView, layout layoutObj: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}


