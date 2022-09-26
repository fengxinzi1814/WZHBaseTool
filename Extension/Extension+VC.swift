//
//  VCExtension.swift
//  ShiGuangJiaSwift
//
//  Created by 汪志浩 on 2022/7/20.
//

import Foundation
import UIKit

extension UIViewController {
    func navHeight() -> CGFloat {
        return navigationController?.navigationBar.frame.size.height ?? 0
    }
    
}
