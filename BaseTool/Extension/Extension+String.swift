//
//  WZHString.swift
//  ShiGuangJiaSwift
//
//  Created by 汪志浩 on 2022/7/6.
//

import Foundation
extension String {
    
    ///字符串去空格
    var trim:String?{
        //        let whiteSpace = CharacterSet.whitespacesAndNewlines
        //        return self.trimmingCharacters(in: whiteSpace)
        return self.replacingOccurrences(of: " ", with: "")
    }
    /// string 转 int
    var toInt:Int?{
        return Int(self)
    }
    
    //MARK: 验证手机号
    var isMobile:Bool{
        
        if self.count == 0 {
            return false
        }
        let mobile = "^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        if regexMobile.evaluate(with: self.trim) == true {
            return true
        } else {
            return false
        }
    }
    
    var encryptMobile : String{
        let newCardNum  = self.trim
        guard let newCardNum = newCardNum , newCardNum.isMobile else{
            return ""
        }
        let result: String = ( newCardNum as NSString).replacingCharacters(in: NSMakeRange(3, newCardNum.count - 7), with: "****")
        return result
    }
    
    /// 验证邮箱
    var isValidEmail: Bool {
        if self.count == 0 {
            return false
        }
        let mobile = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        if regexMobile.evaluate(with: self) == true {
            return true
        } else {
            return false
        }
    }
    
    /// 是否是数字
    var isValidNumber: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^[0-9]+$").evaluate(with: self)
    }
    
    /// 验证 URL
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    /// 身份证
    var isIdCard: Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^(\\d{14}|\\d{17})(\\d|[xX])$").evaluate(with: self)
    }
    
    func htmlAdapter() -> String {
        var content = self.replacingOccurrences(of: "&amp;quot", with: "'")
        content = content.replacingOccurrences(of: "&lt;", with: "<")
        content = content.replacingOccurrences(of: "&gt;", with: ">")
        content = content.replacingOccurrences(of: "&quot;", with: "\"")
        
        if content.contains(".mp4"){
            content = content.replacingOccurrences(of: ".mp4", with: ".mp4#t=1")
        }
        
        return "<html> \n  <head> \n <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" /> \n <style type=\"text/css\"> \n body {font-size:15px;}\n </style> \n </head> \n <body> <script type='text/javascript'> window.onload = function(){\n var $img = document.getElementsByTagName('img');\n for(var p in  $img){\n $img[p].style.width = '100%%';\n $img[p].style.height ='auto'\n }\n } </script>\(content) </body> </html>"
        
    }
    
    // 计算字符串长度
    func sizeWithText(font: UIFont, size: CGSize) -> CGRect {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect;
    }
    
}

extension String {

    // 查找中间字符串
    func subString(prefix: String, tail: String) -> String? {

        if self.count == 0 { return nil }

        let regex = "(?<=\(prefix)).*?(?=\(tail))"
        let regular = try? NSRegularExpression.init(pattern: regex, options: .caseInsensitive)
        guard let range = regular?.firstMatch(in: self, options: .reportCompletion, range: NSRange(location: 0, length: self.count))?.range else {
            return nil
        }

        // 对str字符串进行匹配
        return self.subString(from: range.location, length: range.length)
    }

    /// 字符串截取
    func subString(from: Int) -> String {
        let end = self.count
        return String(self[String.Index.init(utf16Offset: from, in: self)..<String.Index.init(utf16Offset: end, in: self)])
    }

    func subString(from: Int, length: Int) -> String {
        let end = from + length
        if self.count < end {
            return self
        }
        return String(self[String.Index.init(utf16Offset: from, in: self)..<String.Index.init(utf16Offset: end, in: self)])
    }

    func subString(from: Int, to: Int) -> String {
        return String(self[String.Index.init(utf16Offset: from, in: self)..<String.Index.init(utf16Offset: to, in: self)])
    }

}


