//
//  OtherServicesDetailController.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import UIKit

class ServiceDetailViewController: UIViewController {
    
    private let service: ServiceModel
    
    init(service: ServiceModel) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = service.name
        
        let label = UILabel()
        label.text = "All apps for \(service.name)"
        label.textAlignment = .center
        label.frame = view.bounds
        view.addSubview(label)
    }
}

