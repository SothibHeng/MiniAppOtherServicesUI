//
//  ServiceModel.swift
//  MiniAppOtherServices
//
//  Created by Universe on 19/8/25.
//

import Foundation

struct ServiceModel {
    let serviceType: ServiceType
    var name: String { serviceType.name }
    var logo: String { serviceType.logo }
    var url: String { serviceType.url }
    var banner: BannerModel { serviceType.banner }
}
