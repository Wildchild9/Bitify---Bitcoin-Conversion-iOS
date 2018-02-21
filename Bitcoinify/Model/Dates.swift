//
//  Dates.swift
//  Bitify
//
//  Created by Noah Wilder on 2018-02-13.
//  Copyright © 2018 Noah Wilder. All rights reserved.
//

import UIKit

class Dates {
    static func getDatesBetweenInterval(_ startDate: Date, _ endDate: Date, completion: (Bool, [String]) -> Void) {
        // Starting date: "2010-07-17"
        var startDate = startDate
        let calendar = Calendar.current
        var datesArray : [String] = []
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        while startDate <= endDate {
            //    print(fmt.string(from: startDate))
            datesArray.append("\((fmt.string(from: startDate)))")
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        let finished : Bool = true
        completion(finished, datesArray)
    }
    
    static func dateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: dateString)!
    }
}
class NumberOfDates {
    static func printDatesBetweenInterval(_ initialDate: Date, _ endDate: Date, completion: (Bool, Int) -> Void) {
        var startDate = initialDate
        let calendar = Calendar.current
        var datesCount : Int = 0
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        while startDate <= endDate {
            //    print(fmt.string(from: startDate))
            datesCount += 1
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        }
        let finished : Bool = true
        completion(finished, datesCount)
    }
    
}
func returnNumberOfDates(initialDate: Date, endDate: Date, completionHandler: (Int) -> Void) {
    NumberOfDates.printDatesBetweenInterval(initialDate, endDate) { (finished, datesCount) in
        if finished {
            let count = datesCount
            completionHandler(count)
        }
    }
}
func returnDateValue(url: String, initialDate: Date, endDate: Date, completionHandler: @escaping ([Double]) -> Void) {
    
    Dates.getDatesBetweenInterval((Dates.dateFromString("2010-07-18")), Date()) { (finished, datesArray) in
        if finished {
            
            getBitcoinDateArrayData(url: url, dates: datesArray) { (isSuccessful, datesValueArray) in
                if isSuccessful {
                    let array : [Double] = datesValueArray
                    completionHandler(array)
                    
                }
            }
        }
        
        
    }
}
func returnDates(initialDate: Date, endDate: Date, completionHandler: ([String]) -> Void) {
    Dates.getDatesBetweenInterval(initialDate, endDate) { (finished, datesArray) in
        if finished {
            let array = datesArray
            completionHandler(array)
        }
    }
}



