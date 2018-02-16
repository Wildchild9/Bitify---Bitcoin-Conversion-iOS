//
//  Bitcoin Data Model.swift
//  Bitcoinify
//
//  Created by Noah Wilder on 2018-02-16.
//  Copyright © 2018 Noah Wilder. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


func getSpecificBitcoinData(url: String, requestedData: String, currencySelected: String, label: UILabel) {
    
    Alamofire.request(url, method: .get)
        
        .responseJSON { response in
            if response.result.isSuccess {
                
                print("Sucess! Completed the currency conversion")
                //      let bitcoinJSON : JSON = JSON(response.result.value!)
                
                //                    if let bitcoinResult = bitcoinJSON["ask"].double {
                //                       text = "\(currencySelected) \(bitcoinResult)"
                //
                //                    } else {
                //                        label.text = "Price Unavailable"
                //                    }
                
                
                let btcJSON : JSON = JSON(response.result.value!)
                
                
                switch (requestedData) {
                    
                case "[ask]" :
                    if let bitcoinResult = btcJSON["ask"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[bid]" :
                    if let bitcoinResult = btcJSON["bid"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[last]" :
                    if let bitcoinResult = btcJSON["last"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[high]" :
                    if let bitcoinResult = btcJSON["high"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[low]" :
                    if let bitcoinResult = btcJSON["low"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[open][hour]" :
                    if let bitcoinResult = btcJSON["open"]["hour"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[open][day]" :
                    if let bitcoinResult = btcJSON["open"]["day"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[open][week]" :
                    if let bitcoinResult = btcJSON["open"]["week"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[open][month]" :
                    if let bitcoinResult = btcJSON["open"]["month"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[open][month_3]" :
                    if let bitcoinResult = btcJSON["open"]["month_3"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[open][month_6]" :
                    if let bitcoinResult = btcJSON["open"]["month_6"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[open][year]" :
                    if let bitcoinResult = btcJSON["open"]["year"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[averages][day]" :
                    if let bitcoinResult = btcJSON["averages"]["day"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[averages][week]" :
                    if let bitcoinResult = btcJSON["averages"]["week"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[averages][month]" :
                    if let bitcoinResult = btcJSON["averages"]["month"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[volume]" :
                    if let bitcoinResult = btcJSON["volume"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[changes][percent][hour]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["hour"].double {
                        label.text = "\(bitcoinResult)"
                    } else {
                        label.text = "N/A"
                    }
                    
                case "[changes][percent][day]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["day"].double {
                        label.text = "\(bitcoinResult)"
                        print(bitcoinResult)
                    } else {
                        label.text = "N/A"
                    }
                    
                case "[changes][percent][week]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["week"].double {
                        label.text = "\(bitcoinResult)"
                    } else {
                        label.text = "N/A"
                    }
                    
                case "[changes][percent][month]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["month"].double {
                        label.text = "\(bitcoinResult)"
                    } else {
                        label.text = "N/A"
                    }
                    
                case "[changes][percent][month_3]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["month_3"].double {
                        label.text = "\(bitcoinResult)"
                    } else {
                        label.text = "N/A"
                    }
                    
                case "[changes][percent][month_6]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["month_6"].double {
                        label.text = "\(bitcoinResult)"
                    } else {
                        label.text = "N/A"
                    }
                    
                case "[changes][percent][year]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["year"].double {
                        label.text = "\(bitcoinResult)"
                    } else {
                        label.text = "N/A"
                    }
                    
                case "[changes][price][hour]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["hour"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[changes][price][day]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["day"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[changes][price][week]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["week"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[changes][price][month]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["month"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[changes][price][month_3]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["month_3"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[changes][price][month_6]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["month_6"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[changes][price][year]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["year"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[volume_percent]" :
                    if let bitcoinResult = btcJSON["volume_percent"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[timestamp]" :
                    if let bitcoinResult = btcJSON["timestamp"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                case "[display_timestamp]" :
                    if let bitcoinResult = btcJSON["display_timestamp"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                default :
                    if let bitcoinResult = btcJSON["ask"].double {
                        label.text = "\(currencySelected) \(bitcoinResult)"
                    } else {
                        label.text = "Price Unavailable"
                    }
                    
                }
                
                
                
                
                
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                label.text = "Connection Issues"
            }
    }
}

func getSpecificBitcoinDataCompletion(url: String, requestedData: String, currencySelected: String, completion: @escaping (Bool, String) -> Void) {
    
    Alamofire.request(url, method: .get)
        
        .responseJSON { response in
            if response.result.isSuccess {
                
                print("Sucess! Completed the currency conversion")
                //      let bitcoinJSON : JSON = JSON(response.result.value!)
                
                //                    if let bitcoinResult = bitcoinJSON["ask"].double {
                //                       text = "\(currencySelected) \(bitcoinResult)"
                //
                //                    } else {
                //                        label.text = "Price Unavailable"
                //                    }
                
                
                let btcJSON : JSON = JSON(response.result.value!)
                
                
                switch (requestedData) {
                    
                case "[ask]" :
                    if let bitcoinResult = btcJSON["ask"].double {
                        let isSuccess = true
                        let numberFormatter = NumberFormatter()
                        let bitResult : NSNumber = bitcoinResult as NSNumber
                        numberFormatter.numberStyle = NumberFormatter.Style.currency
                        let formattedResult = numberFormatter.string(from: bitResult)
                        let finalResult : String = "\(formattedResult!.dropFirst())"
                        let data = "\(currencySelected) \(finalResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[bid]" :
                    if let bitcoinResult = btcJSON["bid"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[last]" :
                    if let bitcoinResult = btcJSON["last"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[high]" :
                    if let bitcoinResult = btcJSON["high"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[low]" :
                    if let bitcoinResult = btcJSON["low"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[open][hour]" :
                    if let bitcoinResult = btcJSON["open"]["hour"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[open][day]" :
                    if let bitcoinResult = btcJSON["open"]["day"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[open][week]" :
                    if let bitcoinResult = btcJSON["open"]["week"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[open][month]" :
                    if let bitcoinResult = btcJSON["open"]["month"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[open][month_3]" :
                    if let bitcoinResult = btcJSON["open"]["month_3"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[open][month_6]" :
                    if let bitcoinResult = btcJSON["open"]["month_6"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[open][year]" :
                    if let bitcoinResult = btcJSON["open"]["year"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[averages][day]" :
                    if let bitcoinResult = btcJSON["averages"]["day"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[averages][week]" :
                    if let bitcoinResult = btcJSON["averages"]["week"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[averages][month]" :
                    if let bitcoinResult = btcJSON["averages"]["month"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[volume]" :
                    if let bitcoinResult = btcJSON["volume"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][percent][hour]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["hour"].double {
                        let isSuccess = true
                        let data = "\(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][percent][day]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["day"].double {
                        let isSuccess = true
                        let data = "\(bitcoinResult)"
                        completion(isSuccess, data)
                        print(bitcoinResult)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][percent][week]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["week"].double {
                        let isSuccess = true
                        let data = "\(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][percent][month]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["month"].double {
                        let isSuccess = true
                        let data = "\(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][percent][month_3]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["month_3"].double {
                        let isSuccess = true
                        let data = "\(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][percent][month_6]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["month_6"].double {
                        let isSuccess = true
                        let data = "\(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][percent][year]" :
                    if let bitcoinResult = btcJSON["changes"]["percent"]["year"].double {
                        let isSuccess = true
                        let data = "\(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][price][hour]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["hour"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][price][day]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["day"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][price][week]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["week"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][price][month]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["month"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][price][month_3]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["month_3"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][price][month_6]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["month_6"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[changes][price][year]" :
                    if let bitcoinResult = btcJSON["changes"]["price"]["year"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[volume_percent]" :
                    if let bitcoinResult = btcJSON["volume_percent"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[timestamp]" :
                    if let bitcoinResult = btcJSON["timestamp"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                case "[display_timestamp]" :
                    if let bitcoinResult = btcJSON["display_timestamp"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                default :
                    if let bitcoinResult = btcJSON["ask"].double {
                        let isSuccess = true
                        let data = "\(currencySelected) \(bitcoinResult)"
                        completion(isSuccess, data)
                    } else {
                        let isSuccess = false
                        let data = "N/A"
                        completion(isSuccess, data)
                    }
                    
                }
                
                
                
                
                
                
            } else {
                print("Error: \(String(describing: response.result.error))")
                
                let isSuccess = false
                let data = "Connection Issues"
                completion(isSuccess, data)
                
            }
    }
    
}

extension Double {
    func currencyFormat() -> String {
        let num : Double = self
        let numberFormatter = NumberFormatter()
        let result : NSNumber = num as NSNumber
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        let formattedResult = numberFormatter.string(from: result)
        let finalResult : String = "\(formattedResult!.dropFirst())"
        return finalResult
    }
}


/*
 {
 "ask": 8693.49,
 "bid": 8684.24,
 "last": 8691.26,
 "high": 9303.96,
 "low": 7456.06,
 "open": {
 "hour": 8962.63,
 "day": 8658.63,
 "week": 14027.45,
 "month": 20955.59,
 "month_3": 9108.95,
 "month_6": 4043.01,
 "year": 1300.20
 },
 "averages": {
 "day": 8304.76,
 "week": 8690.67,
 "month": 10912.96
 },
 "volume": 602377.81590893,
 "changes": {
 "percent": {
 "hour": -3.03,
 "day": 0.38,
 "week": -38.04,
 "month": -58.53,
 "month_3": -4.59,
 "month_6": 114.97,
 "year": 568.46
 },
 "price": {
 "hour": -271.37,
 "day": 32.63,
 "week": -5336.19,
 "month": -12264.33,
 "month_3": -417.69,
 "month_6": 4648.25,
 "year": 7391.06
 }
 },
 "volume_percent": 0.55,
 "timestamp": 1517928282,
 "display_timestamp": "2018-02-06 14:44:42"
 }
 */

//    "ask": 8693.49,
//    "bid": 8684.24,
//    "last": 8691.26,
//    "high": 9303.96,
//    "low": 7456.06,
//    "open": {
//    "hour": 8962.63,
//    "day": 8658.63,
//    "week": 14027.45,
//    "month": 20955.59,
//    "month_3": 9108.95,
//    "month_6": 4043.01,
//    "year": 1300.20
//    },
//    "averages": {
//    "day": 8304.76,
//    "week": 8690.67,
//    "month": 10912.96
//    },
//    "volume": 602377.81590893,
//    "changes": {
//    "percent": {
//    "hour": -3.03,
//    "day": 0.38,
//    "week": -38.04,
//    "month": -58.53,
//    "month_3": -4.59,
//    "month_6": 114.97,
//    "year": 568.46
//    },
//    "price": {
//    "hour": -271.37,
//    "day": 32.63,
//    "week": -5336.19,
//    "month": -12264.33,
//    "month_3": -417.69,
//    "month_6": 4648.25,
//    "year": 7391.06
//    }
//    },
//    "volume_percent": 0.55,
//    "timestamp": 1517928282,
//    "display_timestamp": "2018-02-06 14:44:42"



