//
//  DateFormatterViewModel.swift
//  SWIFTBasics
//
//  Created by TWINB00776283B on 2025/3/31.
//

import Foundation

class Model {

    let adDateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "zh-CN")
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter
        
    }()
    
    
    func adGetString() -> String{
        return adDateFormatter.string(from: Date())
    }
    
    func adStringToDate(string: String) -> Date {
        
        guard let safedate = adDateFormatter.date(from: string) else { return Date()}
        
        return safedate
        
    }
    
    let rocDateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "zh-CN")
        
        formatter.dateFormat = "yyy/MM/dd"
        
        formatter.calendar = Calendar(identifier: .republicOfChina)
        
        return formatter
        
    }()

    func rocGetString() -> String {
        return rocDateFormatter.string(from: Date())
    }
    
    func rocStringterToDate(string: String) -> Date {
        
        guard let date = rocDateFormatter.date(from: string) else { return Date()}
        
        return date
        
    }
}
