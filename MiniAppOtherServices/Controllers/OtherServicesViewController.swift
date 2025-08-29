//
//  OtherServicesViewController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 20/8/25.
//

import UIKit

class OtherServicesViewController: UIViewController {

    fileprivate enum Section: Int, CaseIterable {
        case banner
        case services
    }

    fileprivate var services: [ServiceModel] {
        ServiceType.allCases.map { ServiceModel(serviceType: $0) }
    }

    fileprivate var banners: [BannerModel] {
        services.map { $0.banner }
    }

    fileprivate lazy var wrapCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true

        collectionView.register(
            OtherServicesSectionHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: OtherServicesSectionHeaderCell.identifier
        )
        
        collectionView.register(BannerContainerCell.self, forCellWithReuseIdentifier: BannerContainerCell.identifier)
        collectionView.register(ServicesContainerCell.self, forCellWithReuseIdentifier: ServicesContainerCell.identifier)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(wrapCollectionView)
        navigationItem.backButtonTitle = ""
        
        view.backgroundColor = .white
        
        wrapCollectionView.backgroundColor = .white
        
        setupNavigationBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        wrapCollectionView.frame = view.bounds.inset(by: view.safeAreaInsets)
    }

    fileprivate func showService(_ service: ServiceModel) {
        let webController = WebViewController(service: service)
        navigationController?.pushViewController(webController, animated: true)
    }
    
    fileprivate func setupNavigationBar() {
        guard let navBar = navigationController?.navigationBar.applyDefaultAppearance() else { return }

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.primary

        let logoImageView = UIImageView(image: UIImage(named: "acleda"))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 135).isActive = true

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImageView)
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
            header.configure(title: "Other Servicesss", titleColor: .primary)
            header.onTap = { [weak self] in
                let allServicesViewController = AllServicesViewController()
//                let allServicesViewController = ACLEDAHomeOtherServiceViewController()
                self?.navigationController?.pushViewController(allServicesViewController, animated: true)
            }
        case .services:
            header.configure(title: "", titleColor: .primary)
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
            cell.onTapViewAll = { [weak self] in
                let allServicesViewController = AllServicesViewController()
                self?.navigationController?.pushViewController(allServicesViewController, animated: true)
            }
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout layoutObj: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width

        if indexPath.section == Section.banner.rawValue {
            return CGSize(width: width, height: 160)
        } else {
            return CGSize(width: width, height: 120)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout layoutObj: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: section == 0 ? 0 : 8, left: 0, bottom: 0, right: 0)
    }
}
