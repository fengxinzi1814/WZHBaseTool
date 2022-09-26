//
//  Extension+Int.swift
//  ShiGuangJiaSwift
//
//  Created by point on 2022/8/17.
//

import Foundation
// MARK: Map
extension Int {
    /**将数字转字符串,当数量大于99的时候显示 99+**/
    func map_MsgCount() -> String {
        return self > 99 ? "99+" : String(self)
    }
    
    /**将数字转字符串,当大于10000的时候,除以10000,保留一位小数**/
    func  map_countStr() -> String {
        if self >= 10000 {
            let formatter = NumberFormatter()
            formatter.numberStyle = . decimal
            formatter.maximumFractionDigits = 1 //最大的小数位数
            formatter.roundingMode = .down
            return ((formatter.string(from: NSNumber(value: (Double(self) / 10000.0))))  ?? "") + "w"
        }else{
            return String(self)
        }
    }
}
