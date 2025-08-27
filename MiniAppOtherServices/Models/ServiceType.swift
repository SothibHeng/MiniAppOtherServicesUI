//
//  ServiceType.swift
//  MiniAppOtherServices
//
//  Created by Universe on 25/8/25.
//


import UIKit

enum ServiceType: CaseIterable {
    case bbc, disney, duolingo, imdb, coursera, khanAcademy, twitch, etsy, reuters, aliExpress
}

extension ServiceType {
    var name: String {
        switch self {
        case .bbc: return "BBC New, In quantum mechanics, particles can exist in many possible states until observed."
        case .disney: return "Disney"
        case .duolingo: return "Duolingo"
        case .imdb: return "IMDB"
        case .coursera: return "Coursera"
        case .khanAcademy: return "Khan Academy"
        case .twitch: return "Twitch"
        case .etsy: return "Etsy"
        case .reuters: return "Reuters"
        case .aliExpress: return "Ali Express"
        }
    }
    
    var logo: String {
        switch self {
        case .bbc: return "bbc-new"
        case .disney: return "disney"
        case .duolingo: return "duolingo"
        case .imdb: return "imbd"
        case .coursera: return "coursera"
        case .khanAcademy: return "khan-academy"
        case .twitch: return "twitch"
        case .etsy: return "etsy"
        case .reuters: return "reuters"
        case .aliExpress: return "ali-express"
        }
    }
    
    var url: String {
        switch self {
        case .bbc: return "https://www.bbc.com/news"
        case .disney: return "https://www.disneyplus.com/"
        case .duolingo: return "https://www.duolingo.com/"
        case .imdb: return "https://www.imdb.com/"
        case .coursera: return "https://www.coursera.org/"
        case .khanAcademy: return "https://www.khanacademy.org/"
        case .twitch: return "https://www.twitch.tv/"
        case .etsy: return "https://www.etsy.com/"
        case .reuters: return "https://www.reuters.com/"
        case .aliExpress: return "https://www.aliexpress.com/"
        }
    }
    
    var banner: BannerModel {
        switch self {
        case .bbc: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 220, height: 220),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .disney: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 130, height: 90),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .duolingo: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 120, height: 120),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .imdb: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 150, height: 120),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .coursera: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 110, height: 80),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .khanAcademy: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 135, height: 135),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .twitch: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 135, height: 135),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .etsy: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 120, height: 120),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .reuters: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 160, height: 160),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        case .aliExpress: return BannerModel(
            imageName: UIImage(named: logo)!,
            size: .init(width: 200, height: 200),
            backgroundColor: UIColor(cgColor: serviceBackgroundColor.cgColor)
        )
        }
    }
    
    var serviceBackgroundColor: UIColor {
        switch self {
        case .bbc: return .bbcNew
        case .disney: return .disney
        case .aliExpress: return .white
        case .coursera: return .white
        case .duolingo: return .white
        case .etsy: return .white
        case .imdb: return .imbd
        case .khanAcademy: return .white
        case .reuters: return .reuters
        case .twitch: return .twitch
        }
    }
    
    var logoSize: CGSize {
        switch self {
        case .bbc: return CGSize(width: 110, height: 110)
        case .aliExpress: return CGSize(width: 80, height: 80)
        case .coursera: return CGSize(width: 50, height: 50)
        case .disney: return CGSize(width: 60, height: 60)
        case .duolingo: return CGSize(width: 65, height: 65)
        case .etsy: return CGSize(width: 60, height: 60)
        case .imdb: return CGSize(width: 60, height: 60)
        case .khanAcademy: return CGSize(width: 80, height: 80)
        case .reuters: return CGSize(width: 60, height: 60)
        case .twitch: return CGSize(width: 65, height: 65)
        }
    }
}
