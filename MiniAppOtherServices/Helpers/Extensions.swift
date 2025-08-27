//
//  Extensions.swift
//  MiniAppOtherServices
//
//  Created by Universe on 18/8/25.
//

import UIKit

extension UIStackView {
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = .fillEqually
    }
}

extension UIColor {
    static var whiteSmoke: UIColor {
        return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    }
    
    static var lightBorder: UIColor {
        return UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
    }
    
    static var background: UIColor {
        return UIColor(red: 237/255, green: 245/255, blue: 255/255, alpha: 1.0)
    }
    
    static var sunYellow: UIColor {
        return UIColor(red: 255/255, green: 179/255, blue: 15/255, alpha: 1.0)
    }
    
    static var primary: UIColor {
        return UIColor(red: 31/255, green: 67/255, blue: 117/255, alpha: 1.0)
    }
    
    static var titleColor: UIColor {
            return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }
    
    static var subtitleColor: UIColor {
        return UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
    }
    
    static var disney: UIColor {
        return UIColor(red: 54/255, green: 45/255, blue: 102/255, alpha: 1.0)
    }
    
    static var twitch: UIColor {
        return UIColor(red: 69/255, green: 16/255, blue: 147/255, alpha: 1.0)
    }
    
    static var imbd: UIColor {
        return UIColor(red: 244/255, green: 197/255, blue: 24/255, alpha: 1.0)
    }
    
    static var khanAcedemy: UIColor {
        return UIColor(red: 25/255, green: 100/255, blue: 241/255, alpha: 1.0)
    }
    
    static var duolingo: UIColor {
        return UIColor(red: 88/255, green: 203/255, blue: 5/255, alpha: 1.0)
    }
    
    static var coursera: UIColor {
        return UIColor(red: 1/255, green: 86/255, blue: 209/255, alpha: 1.0)
    }
    
    static var etsy: UIColor {
        return UIColor(red: 241/255, green: 100/255, blue: 29/255, alpha: 1.0)
    }
    
    static var aliExpress: UIColor {
        return UIColor(red: 254/255, green: 33/255, blue: 81/255, alpha: 1.0)
    }
    
    static var bbcNew:UIColor {
        return UIColor(red: 186/255, green: 1/255, blue: 1/255, alpha: 1.0)
    }
    
    static var reuters: UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }
}

extension UIView {
    func sizeSubView(size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
}

