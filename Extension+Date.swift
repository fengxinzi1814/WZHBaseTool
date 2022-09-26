//
//  DateExtension.swift
//  ShiGuangJiaSwift
//
//  Created by 汪志浩 on 2022/7/17.
//

import Foundation
extension Date
{

    var dayInWeek : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self as Date)
    }
    
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self as Date)
    }
    
    var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter.string(from: self as Date)
    }
    
    var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: self as Date)
    }
    
    var dateAsPrettyString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd<>MM<>yyyy"
        return formatter.string(from: self as Date)
    }
}

import Foundation

extension DateFormatter {

    convenience init (format: String) {
        self.init()
        dateFormat = format
        locale = Locale.current
    }
}

extension String {

    func toDate (dateFormatter: DateFormatter) -> Date? {
        return dateFormatter.date(from: self)
    }

    func toDateString (dateFormatter: DateFormatter, outputFormat: String) -> String? {
        guard let date = toDate(dateFormatter: dateFormatter) else { return nil }
        return DateFormatter(format: outputFormat).string(from: date)
    }
    
    /**比较两个字符串时间 dataStr1 > dataStr2  **/
   static func sortDataString(dataStr1:String,dataStr2:String) -> Bool{
      let  data1 = dataStr1.toDate(dateFormatter: DateFormatter(format: "yyyy-MM"))
        let  data2 = dataStr2.toDate(dateFormatter: DateFormatter(format: "yyyy-MM"))
        
        if let data1 = data1,let data2 = data2 {
            let intervalStart = data1.timeIntervalSince1970
            let intervalStop = data2.timeIntervalSince1970
            
            return intervalStart > intervalStop
        }
        
        return false
    }

    func mapTimeString() -> String {
        if let data = self.toDate(dateFormatter: DateFormatter(format: "yyyy.MM.dd HH:mm:ss")){
            return data.timeString()
        }else{
            return self
        }
    }
}

extension Date {

    func toString (dateFormatter: DateFormatter) -> String? {
        return dateFormatter.string(from: self)
    }
    
}

extension Date {
    func timeString() -> String {
        let calender = Calendar.current
        let nowComponer = calender.dateComponents([.day,.month,.year], from: Date())
        let selfComponer = calender.dateComponents([.day,.month,.year], from: self)
        
        let cmps = calender.dateComponents([.day], from: selfComponer, to: nowComponer)
        if cmps.day == 0 {
            return "今日"
        }else if cmps.day == 1 {
            return "昨日"
        }else if cmps.day == 1 {
            return "前天"
        } else {
            return self.toString(dateFormatter: DateFormatter(format: "MM月dd日 ")) ?? ""
        }
    }
}
