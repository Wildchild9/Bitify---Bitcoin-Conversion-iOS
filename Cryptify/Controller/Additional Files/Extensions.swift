//
//  Extensions.swift
//  Bitcoinify
//
//  Created by Noah Wilder on 2018-02-16.
//  Copyright © 2018 Noah Wilder. All rights reserved.
//

import UIKit



//MARK: - My Colours
extension UIColor {
    
    static let mint = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1) // 00FA92
    static let strawberry = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1) // FF2F92
    static let blackberry = #colorLiteral(red: 0.01428075787, green: 0, blue: 0.1081325635, alpha: 1) // 03001B
    static let burntOrange = #colorLiteral(red: 0.9931957126, green: 0.3331764638, blue: 0.2069928646, alpha: 1) // FD5434
    static let mintCompliment = #colorLiteral(red: 0.9803921569, green: 0, blue: 0.4078431373, alpha: 1) // FA0068
    
}




//MARK: - Rotation extension for restart button
    extension UIButton {
        func startRotate() {
            let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.fromValue = 0
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 2
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            self.layer.add(rotation, forKey: "rotationAnimation")
        }
        
        func stopRotate() {
            self.layer.removeAnimation(forKey: "rotationAnimation")
        }
    }





//MARK: - Currency formay extension
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







//MARK: - Date to YYYY-MM-DD Formate (Date to String)
    extension Date {
        func formattedDate() -> String {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            let returnString : String = String(format.string(from: self))
            return returnString
        }
    }







//MARK: - Round To Tens
    extension Int {
        func roundToTens(x : Double) -> Int {
            return 10 * Int(round(x / 10.0))
        }
    }








//MARK: - String to Short Month Format (String to String)
    extension String {
        func month() -> String {
            let date = Dates.dateFromString(self)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            let returnValue = String(formatter.string(from: date))
            return returnValue
        }
    }








//MARK: - String to MMM-DD Format (String to String)
    extension String {
        func monthDay() -> String {
            let date = Dates.dateFromString(self)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd"
            let returnValue = String(formatter.string(from: date))
            return returnValue
        }
    }










//MARK: - String to MMM-YY Format (String to String)
    extension String {
        func monthYR() -> String {
            //  let space = " "
            let date = Dates.dateFromString(self)
            let monthFormatter = DateFormatter()
            let yearFormatter = DateFormatter()
            monthFormatter.dateFormat = "MMM"
            yearFormatter.dateFormat = "YY"
            let month = String(monthFormatter.string(from: date)) // + space
            let year = String(yearFormatter.string(from: date))
            let returnValue = month + year
            
            return returnValue
        }
    }









//MARK: - Hex Code to UIColor
    extension UIColor { // UIColor --> Hex String
        var hexString: String {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            
            self.getRed(&r, green: &g, blue: &b, alpha: &a)
            
            return String(
                format: "%02X%02X%02X",
                Int(r * 0xff),
                Int(g * 0xff),
                Int(b * 0xff)
            )
        }
    }








//MARK: - UIColor to Hex Code
    extension UIColor { // Hex String --> UIColor
        convenience init(hex: String) {
            let scanner = Scanner(string: hex)
            scanner.scanLocation = 0
            
            var rgbValue: UInt64 = 0
            
            scanner.scanHexInt64(&rgbValue)
            
            let r = (rgbValue & 0xff0000) >> 16
            let g = (rgbValue & 0xff00) >> 8
            let b = rgbValue & 0xff
            
            self.init(
                red: CGFloat(r) / 0xff,
                green: CGFloat(g) / 0xff,
                blue: CGFloat(b) / 0xff, alpha: 1
            )
        }
    }

