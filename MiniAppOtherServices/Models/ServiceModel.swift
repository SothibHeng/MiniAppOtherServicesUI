//
//  ServiceModel.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import Foundation
import UIKit

struct ServiceModel {
    let serviceType: ServiceType
    var name: String { serviceType.name }
    var logo: String { serviceType.logo }
    var url: String { serviceType.url }
    var banner: BannerModel { serviceType.banner }
    var backgroundColor: UIColor { serviceType.serviceBackgroundColor }
    var logoSize: CGSize { serviceType.logoSize }
}
