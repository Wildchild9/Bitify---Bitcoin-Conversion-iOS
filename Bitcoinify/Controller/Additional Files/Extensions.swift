//
//  Extensions.swift
//  Bitcoinify
//
//  Created by Noah Wilder on 2018-02-16.
//  Copyright © 2018 Noah Wilder. All rights reserved.
//

import UIKit

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
