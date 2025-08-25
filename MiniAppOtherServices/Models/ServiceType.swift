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
        case .bbc: return "BBC News"
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
        case .bbc: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 120, height: 80), backgroundColor: .bbcNew)
        case .disney: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 130, height: 90), backgroundColor: .disney)
        case .duolingo: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 110, height: 110), backgroundColor: .duolingo)
        case .imdb: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 150, height: 70), backgroundColor: .imbd)
        case .coursera: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 110, height: 90), backgroundColor: .coursera)
        case .khanAcademy: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 120, height: 90), backgroundColor: .khanAcedemy)
        case .twitch: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 120, height: 100), backgroundColor: .twitch)
        case .etsy: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 110, height: 80), backgroundColor: .white)
        case .reuters: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 120, height: 70), backgroundColor: .reuters)
        case .aliExpress: return BannerModel(image: UIImage(named: logo)!, size: .init(width: 140, height: 80), backgroundColor: .white)
        }
    }
}
