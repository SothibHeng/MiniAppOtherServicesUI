//
//  OtherServicesViewController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

class OtherServicesViewController: UIViewController {

    private enum Section: Int, CaseIterable {
        case banner
        case services
    }

    fileprivate var banners: [BannerModel] = [
        BannerModel(
            image: UIImage(named: "bbc-new")!,
            size: .init(width: 120, height: 80),
            backgroundColor: .bbcNew
        ),
        BannerModel(image: UIImage(
            named: "duolingo")!,
            size: .init(width: 110, height: 110
        ),
            backgroundColor: .duolingo),
        BannerModel(
            image: UIImage(named: "imbd")!,
            size: .init(width: 150, height: 70),
            backgroundColor: .imbd
        ),
        BannerModel(
            image: UIImage(named: "coursera")!,
            size: .init(width: 110, height: 90),
            backgroundColor: .coursera
        ),
        BannerModel(
            image: UIImage(named: "khan-academy")!,
            size: .init(width: 120, height: 90),
            backgroundColor: .khanAcedemy
        ),
        BannerModel(
            image: UIImage(named: "twitch")!,
            size: .init(width: 120, height: 100),
            backgroundColor: .twitch
        ),
        BannerModel(
            image: UIImage(named: "disney")!,
            size: .init(width: 130, height: 90),
            backgroundColor: .disney
        ),
        BannerModel(
            image: UIImage(named: "etsy")!,
            size: .init(width: 110, height: 80),
            backgroundColor: .white
        ),
        BannerModel(
            image: UIImage(named: "reuters")!,
            size: .init(width: 120, height: 70),
            backgroundColor: .reuters
        ),
        BannerModel(
            image: UIImage(named: "ali-express")!,
            size: .init(width: 140, height: 80),
            backgroundColor: .white
        )
    ]

    fileprivate var services: [ServiceModel] = [
        ServiceModel(name: "BBC New", logo: "bbc-new", url: "https://www.bbc.com/news"),
        ServiceModel(name: "Duolingo", logo: "duolingo", url: "https://www.duolingo.com/"),
        ServiceModel(name: "IMBD", logo: "imbd", url: "https://www.imdb.com/"),
        ServiceModel(name: "Coursera", logo: "coursera", url: "https://www.coursera.org/"),
        ServiceModel(name: "Khan Academy", logo: "khan-academy", url: "https://www.khanacademy.org/"),
        ServiceModel(name: "Twitch", logo: "twitch", url: "https://www.twitch.tv/"),
        ServiceModel(name: "Disney", logo: "disney", url: "https://www.disneyplus.com/"),
        ServiceModel(name: "Etsy", logo: "etsy", url: "https://www.etsy.com/"),
        ServiceModel(name: "Reuters", logo: "reuters", url: "https://www.reuters.com/"),
        ServiceModel(name: "Ali Express", logo: "ali-express", url: "https://www.aliexpress.com/")
    ]
    
    fileprivate lazy var wrapConllectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true

        collectionView.register(BannerContainerCell.self,  forCellWithReuseIdentifier: BannerContainerCell.identifier)
        collectionView.register(ServicesContainerCell.self, forCellWithReuseIdentifier: ServicesContainerCell.identifier)

        collectionView.register(OtherServicesSectionHeaderCell.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: OtherServicesSectionHeaderCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Mini App Implementation"
        view.backgroundColor = .yellow
//        view.backgroundColor = .systemBackground
        view.addSubview(wrapConllectionView)
        
        wrapConllectionView.backgroundColor = .purple
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wrapConllectionView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }

//    private func showService(_ service: ServiceModel) {
//        guard let url = URL(string: service.url) else { return }
//        UIApplication.shared.open(url, options: [:], completionHandler: nil)
//    }
    
    private func showService(_ service: ServiceModel) {
        guard let url = URL(string: service.url) else { return }
        let webVC = WebViewController(url: url)
        navigationController?.pushViewController(webVC, animated: true)
    }
}

extension OtherServicesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        let section = Section(rawValue: indexPath.section)!
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: OtherServicesSectionHeaderCell.identifier,
            for: indexPath
        ) as! OtherServicesSectionHeaderCell

        switch section {
        case .banner:
            header.configure(title: "Other Services")
            header.onTap = { [weak self] in
                let allServicesViewController = AllServicesViewController()
                self?.navigationController?.pushViewController(allServicesViewController, animated: true)
            }
        case .services:
            header.configure(title: "")
            header.onTap = nil
        }
        return header
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        switch Section(rawValue: section)! {
        case .banner:
            return CGSize(width: width, height: 56)
        case .services:
            return .zero
        }
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = Section(rawValue: indexPath.section)!

        switch section {
        case .banner:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerContainerCell.identifier, for: indexPath) as! BannerContainerCell
            cell.configure(with: banners)
            return cell

        case .services:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServicesContainerCell.identifier, for: indexPath) as! ServicesContainerCell
            cell.configure(with: services)
            cell.onSelectService = { [weak self] service in
                self?.showService(service)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout layoutObj: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width

        if indexPath.section == Section.banner.rawValue {
            return CGSize(width: width, height: 224)
        } else {
            return CGSize(width: width, height: 110)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout layoutObj: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: section == 0 ? 0 : 8, left: 0, bottom: 0, right: 0)
    }
}

