//
//  RootController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 18/8/25.
//

import UIKit

class OtherServicesViewController: UIViewController {
    
    private var banners: [BannerModel] = [
        BannerModel(image: UIImage(named: "bbc-new")!, size: CGSize(width: 120, height: 80)),
        BannerModel(image: UIImage(named: "duolingo")!, size: CGSize(width: 160, height: 120)),
        BannerModel(image: UIImage(named: "imbd")!, size: CGSize(width: 150, height: 80)),
        BannerModel(image: UIImage(named: "coursera")!, size: CGSize(width: 120, height: 120)),
        BannerModel(image: UIImage(named: "khan-academy")!, size: CGSize(width: 140, height: 140)),
        BannerModel(image: UIImage(named: "twitch")!, size: CGSize(width: 70, height: 70)),
        BannerModel(image: UIImage(named: "disney")!, size: CGSize(width: 120, height: 80)),
        BannerModel(image: UIImage(named: "etsy")!, size: CGSize(width: 80, height: 80)),
        BannerModel(image: UIImage(named: "reuters")!, size: CGSize(width: 120, height: 60)),
        BannerModel(image: UIImage(named: "ali-express")!, size: CGSize(width: 160, height: 120))
    ]
    
    private var services: [ServiceModel] = [
        ServiceModel(name: "BBC New", icon: "bbc-new"),
        ServiceModel(name: "Duolingo", icon: "duolingo"),
        ServiceModel(name: "IMBD", icon: "imbd"),
        ServiceModel(name: "Coursera", icon: "coursera"),
        ServiceModel(name: "Khan Academy", icon: "khan-academy"),
        ServiceModel(name: "Twitch", icon: "twitch"),
        ServiceModel(name: "Disney", icon: "disney"),
        ServiceModel(name: "Etsy", icon: "etsy"),
        ServiceModel(name: "Reuters", icon: "reuters"),
        ServiceModel(name: "Ali Express", icon: "ali-express"),
    ]
    
    // Banner CollectionView
    private let bannerCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        return cv
    }()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        return pc
    }()
    
    // Services CollectionView
    private let serviceCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .cyan
        view.backgroundColor = .systemBackground
        title = "Other Services"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // Banner setup
        bannerCollection.register(BannerCellView.self, forCellWithReuseIdentifier: BannerCellView.identifier)
        bannerCollection.delegate = self
        bannerCollection.dataSource = self
        view.addSubview(bannerCollection)
        view.addSubview(pageControl)
        pageControl.numberOfPages = banners.count
        
        // Services setup
        serviceCollection.register(OtherServicesCellView.self, forCellWithReuseIdentifier: OtherServicesCellView.identifier)
        serviceCollection.delegate = self
        serviceCollection.dataSource = self
        view.addSubview(serviceCollection)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safe = view.safeAreaInsets
        bannerCollection.frame = CGRect(x: 0, y: safe.top + 10, width: view.frame.size.width, height: 200)
        pageControl.frame = CGRect(x: 0, y: bannerCollection.frame.maxY - 30, width: view.frame.size.width, height: 20)
        serviceCollection.frame = CGRect(x: 0, y: bannerCollection.frame.maxY + 40, width: view.frame.size.width, height: 100)
    }
}

// MARK: - CollectionView Delegates
extension OtherServicesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollection {
            return banners.count
        } else {
            return services.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bannerCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCellView.identifier, for: indexPath) as! BannerCellView
            cell.configure(banner: banners[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherServicesCellView.identifier, for: indexPath) as! OtherServicesCellView
            cell.configure(service: services[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == serviceCollection {
            let service = services[indexPath.row]
            let vc = ServiceDetailViewController(service: service)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == bannerCollection {
            guard scrollView.frame.size.width > 0 else { return }
            let page = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
            pageControl.currentPage = page
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollection {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else {
            return CGSize(width: 80, height: 80)
        }
    }
}

