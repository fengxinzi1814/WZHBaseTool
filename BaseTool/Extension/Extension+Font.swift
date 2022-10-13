//
//  Extension+Font.swift
//  ShiGuangJiaSwift
//
//  Created by point on 2022/8/31.
//

import Foundation
import UIKit

extension UIFont {
    static func PF_Semibold(size:CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func PF_Regular(size:CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func PF_Medium(size:CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func DIN_Medium(size:CGFloat) -> UIFont {
        return UIFont(name: "DIN-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func DIN_Bold(size:CGFloat) -> UIFont {
        return UIFont(name: "D-DIN", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
