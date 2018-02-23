//
//  BitcoinDateData.swift
//  Bitify
//
//  Created by Noah Wilder on 2018-02-13.
//  Copyright © 2018 Noah Wilder. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON



func getBitcoinDateArrayData(url: String, dates: [String], completion: @escaping (Bool, [Double]) -> Void) {
    
    Alamofire.request(url, method: .get)
        
        .responseJSON { response in
            if response.result.isSuccess {
                
                print("Sucess! Completed the currency conversion (part one)")
                
                let btcJSON : JSON = JSON(response.result.value!)
                var isSuccess : Bool = true
                var datesValueArray : [Double] = []
                print(btcJSON)
                print(url)
                print(dates)
                //                https://api.coindesk.com/v1/bpi/historical/close.json?start=2017-02-07&end=2017-02-16
                //                https://api.coindesk.com/v1/bpi/historical/close.json?start=2018-02-10&end=2018-02-16
                for day in 1...dates.count {
                    
                    if let bitcoinResult = btcJSON["bpi"]["\(dates[day-1])"].double {
                        let data : Double = bitcoinResult
                        isSuccess = true
                        datesValueArray.append(data)
                        //print("Date #\(datesValueArray.count) -> \(data), \(isSuccess)")
                        print("Date\(datesValueArray.count) - \(dates[day - 1]) ⟶ \(data), \(isSuccess)")
                    } else {
                        isSuccess = false
                    }
                }
                completion(isSuccess, datesValueArray)
                
                
                
                
                
                
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                
                let isSuccess = false
                let data : [Double] = [0]
                completion(isSuccess, data)
                
            }
    }
    
}

func getBitcoinDateArrayDataDictionary(url: String, dates: [String], completion: @escaping (Bool, [String : Double]?) -> Void) {
    
    Alamofire.request(url, method: .get)
        
        .responseJSON { response in
            if response.result.isSuccess {
                
                print("Sucess! Completed the currency conversion")
                
                let btcJSON : JSON = JSON(response.result.value!)
                var totalSuccess : Bool = true
                var datesValueArray : [String: Double] = [:]
                
                for day in 1...dates.count {
                    
                    if let bitcoinResult = btcJSON["bpi"]["\(dates[day - 1])"].double {
                        let data : Double = bitcoinResult
                        let currentDate = "\(dates[day - 1])"
                        datesValueArray[currentDate] = data
                    } else {
                        totalSuccess = false
                    }
                }
                if totalSuccess == false {
                    let isSuccess = false
                    completion(isSuccess, nil)
                } else {
                    let isSuccess = true
                    completion(isSuccess, datesValueArray)
                }
                
                
                
                
                
                
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                
                let isSuccess = false
                completion(isSuccess, nil)
                
            }
    }
    
}

func getBitcoinSingleDateData(url: String, date: String, completion: @escaping (Bool, Double) -> Void) {
    
    Alamofire.request(url, method: .get)
        
        .responseJSON { response in
            if response.result.isSuccess {
                
                print("Sucess! Completed the currency conversion")
                
                
                
                let btcJSON : JSON = JSON(response.result.value!)
                
                if let bitcoinResult = btcJSON["bpi"]["\(date)"].double {
                    let isSuccess = true
                    let data : Double = bitcoinResult
                    completion(isSuccess, data)
                } else {
                    let isSuccess = false
                    let data : Double = 0
                    completion(isSuccess, data)
                }
                
                
                
                
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                
                let isSuccess = false
                let data : Double = 0
                completion(isSuccess, data)
                
            }
    }
    
}
func getBitcoinCurrentData(completion: @escaping (Bool, Double) -> Void) {
    Alamofire.request("https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCUSD", method: .get).responseJSON { response in
        
        if response.result.isSuccess {
            
            print("Sucess! Completed the currency conversion (part two)")
            ///      let bitcoinJSON : JSON = JSON(response.result.value!)
            
            if let bitcoinResult = JSON(response.result.value!)["ask"].double {
                let currentPrice : Double = bitcoinResult
                let isCompleted = true
                completion(isCompleted, currentPrice)
            } else {
                let currentPrice : Double = 0
                let isCompleted = false
                completion(isCompleted, currentPrice)
            }
        } else {
            print("Error: \(String(describing: response.result.error))")
            
            let isCompleted = false
            let data : Double = 0
            completion(isCompleted, data)
            
        }
    }
}


