//
//  BannerContainerCellView.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class BannerContainerCell: UICollectionViewCell {
    static let identifier = "BannerContainerCell"

    private var banners: [BannerModel] = []
    private var pageControllers: [UIViewController] = []
    
    private var timer: Timer?
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.hidesForSinglePage = true
        return pc
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pvc.dataSource = self
        pvc.delegate = self
        return pvc
    }()
    
    private var currentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        contentView.addSubview(pageViewController.view)
        contentView.addSubview(pageControl)
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height - 24)
        pageControl.frame = CGRect(x: 0, y: contentView.bounds.height - 24, width: contentView.bounds.width, height: 24)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let paddingHorizontal: CGFloat = 16
        let paddingTop: CGFloat = 18
        let pageControlHeight: CGFloat = 24
        
        let width = contentView.bounds.width - 2 * paddingHorizontal
        let height = contentView.bounds.height - paddingTop
        
        pageViewController.view.frame = CGRect(
            x: paddingHorizontal,
            y: paddingTop,
            width: width,
            height: height - pageControlHeight
        )
    }
    
    func configure(with banners: [BannerModel]) {
        self.banners = banners
        self.pageControllers = banners.map { BannerViewController(banner: $0) }
        
        pageControllers.forEach { vc in
            if let bannerVC = vc as? BannerViewController {
                bannerVC.pageControl.numberOfPages = banners.count
            }
        }
        
        currentIndex = 0
        
        if let first = pageControllers.first {
            pageViewController.setViewControllers([first], direction: .forward, animated: true)
        }
        
        updateCurrentPage()
        startAutoSlide()
    }

    private func updateCurrentPage() {
        // Update current page indicator on visible banner
        if let currentVC = pageViewController.viewControllers?.first as? BannerViewController {
            currentVC.pageControl.currentPage = currentIndex
        }
    }

    private func goToNextPage() {
        guard !pageControllers.isEmpty else { return }
        let nextIndex = (currentIndex + 1) % pageControllers.count
        let nextVC = pageControllers[nextIndex]
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true)
        currentIndex = nextIndex
        updateCurrentPage()
    }

    
    private func startAutoSlide() {
        timer?.invalidate()
        guard banners.count > 1 else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.goToNextPage()
        }
    }
    
    deinit { timer?.invalidate() }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension BannerContainerCell: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageControllers.firstIndex(of: viewController) else { return nil }
        let prevIndex = (index - 1 + pageControllers.count) % pageControllers.count
        return pageControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = (index + 1) % pageControllers.count
        return pageControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first, let index = pageControllers.firstIndex(of: currentVC) {
            currentIndex = index
            pageControl.currentPage = index
        }
    }
}



