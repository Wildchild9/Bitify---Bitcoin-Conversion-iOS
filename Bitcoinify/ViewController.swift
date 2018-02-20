//
//  ViewController.swift
//  Bitcoinify
//
//  Created by Noah Wilder on 2018-02-16.
//  Copyright © 2018 Noah Wilder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    var currencySelected = ""
    var runs : Int = 0
    var bitcoinPrice : Double = 0
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["Select currency", "AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    //  let onlyCurrencyARray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    let currencySymbolsArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    
    
    var bitcoinHeight : CGFloat = 0
    var bitcoinWidth : CGFloat = 0
    var bitcoinX : CGFloat = 0
    var bitcoinY : CGFloat = 0
    var arrowLocationX : CGFloat = 0
    var arrowLocationY : CGFloat = 0
    var arrowWidth : CGFloat = 0
    var arrowHeight : CGFloat = 0
    var btcLocationX : CGFloat = 0
    var btcLocationY : CGFloat = 0
    var btcWidth : CGFloat = 0
    var btcHeight : CGFloat = 0
    var currencyLocationX : CGFloat = 0
    var currencyLocationY : CGFloat = 0
    var currencyWidth : CGFloat = 0
    var currencyHeight : CGFloat = 0
    var previousIcon : UIImageView?
    var percentOfChange : String = ""
    let negativeColour : UIColor = #colorLiteral(red: 0.9960739017, green: 0.2244686782, blue: 0.1838099957, alpha: 1)
    let positiveColour : UIColor = #colorLiteral(red: 0.1101273373, green: 0.9998249412, blue: 0.2622338533, alpha: 1)
    let webNegativeColour : UIColor = #colorLiteral(red: 0.9983710647, green: 0.2906047106, blue: 0.4062339067, alpha: 1)
    let webPositiveColour : UIColor = #colorLiteral(red: 0.2362090647, green: 0.7374139428, blue: 0.5960354209, alpha: 1)
    //    var currentIcon : UIImageView?
    // var previousIcon : UIImageView?
    
    
    //  let bitcoinDataModel = BitcoinDataModel()
    
    //Pre-setup IBOutlets
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var bitcoinHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bitcoinWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var arrow: UILabel!
    @IBOutlet weak var BTC: UIImageView!
    @IBOutlet weak var AUD: UIImageView!
    @IBOutlet weak var BRL: UIImageView!
    @IBOutlet weak var CAD: UIImageView!
    @IBOutlet weak var CNY: UIImageView!
    @IBOutlet weak var EUR: UIImageView!
    @IBOutlet weak var GBP: UIImageView!
    @IBOutlet weak var HKD: UIImageView!
    @IBOutlet weak var IDR: UIImageView!
    @IBOutlet weak var ILS: UIImageView!
    @IBOutlet weak var INR: UIImageView!
    @IBOutlet weak var JPY: UIImageView!
    @IBOutlet weak var MXN: UIImageView!
    @IBOutlet weak var NOK: UIImageView!
    @IBOutlet weak var NZD: UIImageView!
    @IBOutlet weak var PLN: UIImageView!
    @IBOutlet weak var RON: UIImageView!
    @IBOutlet weak var RUB: UIImageView!
    @IBOutlet weak var SEK: UIImageView!
    @IBOutlet weak var SGD: UIImageView!
    @IBOutlet weak var USD: UIImageView!
    @IBOutlet weak var ZAR: UIImageView!
    @IBOutlet weak var currencyIconContainer: UIView!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel! /////////////////////////
    @IBOutlet weak var bitcoin: UIImageView!
    
    
    var iconArray : [UIImageView] = []
    var iconArrayBTC : [UIImageView] = []
    var centerLocation : CGFloat = 0
    var currentRow : Int = 0
    var currentDisplayRow : Int = 0
    var smallWidth : CGFloat = 0//btcWidth - 50
    var smallHeight : CGFloat = 0//btcHeight - (50 * (self.btcHeight / self.btcWidth))
    var smallY : CGFloat = 0//currencyLocationY - 30
    var smallX : CGFloat = 0//currencyLocationX + 25
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smallWidth = btcWidth - 50
        smallHeight = btcHeight - (50 * (self.btcHeight / self.btcWidth))
        smallY = currencyLocationY - 30
        smallX = currencyLocationX + 25
        bitcoinHeight = bitcoin.frame.size.height
        bitcoinWidth = bitcoin.frame.size.width
        bitcoinX = bitcoin.frame.origin.x
        bitcoinY = bitcoin.frame.origin.y
        centerLocation = (BTC.frame.origin.x + CAD.frame.origin.x) / 2//((BTC.frame.origin.x + transportContainer.frame.origin.x) / 2)
        iconArray = [AUD, BRL, CAD, CNY, EUR, GBP, HKD, IDR, ILS, INR, JPY, MXN, NOK, NZD, PLN, RON, RUB, SEK, SGD, USD, ZAR]
        iconArrayBTC = [AUD, BRL, CAD, CNY, EUR, GBP, HKD, IDR, ILS, INR, JPY, MXN, NOK, NZD, PLN, RON, RUB, SEK, SGD, USD, ZAR, BTC]
        iconArray.remove(at: 0)
        arrowLocationX = arrow.frame.origin.x
        arrowLocationY = arrow.frame.origin.y
        arrowWidth = arrow.frame.size.width
        arrowHeight = arrow.frame.size.height
        btcLocationX = BTC.frame.origin.x
        btcLocationY = BTC.frame.origin.y
        btcWidth = BTC.frame.size.width
        btcHeight = BTC.frame.size.height
        currencyLocationX = CAD.frame.origin.x
        currencyLocationY = CAD.frame.origin.y
        currencyWidth = CAD.frame.size.width
        currencyHeight = CAD.frame.size.height
        
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        changeLabel.text = " "
        
        
        for item in 1...iconArrayBTC.count {
            iconArrayBTC[item-1].frame.origin.x = centerLocation
        }
        
        AUD.frame.origin.x = centerLocation
        BRL.frame.origin.x = centerLocation
        CAD.frame.origin.x = centerLocation
        CNY.frame.origin.x = centerLocation
        EUR.frame.origin.x = centerLocation
        GBP.frame.origin.x = centerLocation
        HKD.frame.origin.x = centerLocation
        IDR.frame.origin.x = centerLocation
        ILS.frame.origin.x = centerLocation
        INR.frame.origin.x = centerLocation
        JPY.frame.origin.x = centerLocation
        MXN.frame.origin.x = centerLocation
        NOK.frame.origin.x = centerLocation
        NZD.frame.origin.x = centerLocation
        PLN.frame.origin.x = centerLocation
        RON.frame.origin.x = centerLocation
        RUB.frame.origin.x = centerLocation
        SEK.frame.origin.x = centerLocation
        SGD.frame.origin.x = centerLocation
        USD.frame.origin.x = centerLocation
        ZAR.frame.origin.x = centerLocation
        BTC.frame.origin.x = centerLocation
        
        AUD.isHidden = true
        BRL.isHidden = true
        CAD.isHidden = true
        CNY.isHidden = true
        EUR.isHidden = true
        GBP.isHidden = true
        HKD.isHidden = true
        IDR.isHidden = true
        ILS.isHidden = true
        INR.isHidden = true
        JPY.isHidden = true
        MXN.isHidden = true
        NOK.isHidden = true
        NZD.isHidden = true
        PLN.isHidden = true
        RON.isHidden = true
        RUB.isHidden = true
        SEK.isHidden = true
        SGD.isHidden = true
        USD.isHidden = true
        ZAR.isHidden = true
        BTC.frame.origin.x = centerLocation
        
        BTC.alpha = 0
        currencyPicker.alpha = 0
        reloadButton.alpha = 0
        arrow.isHidden = true
        
        
        //        changeLabel.isHidden = true /**************************/
        //   changeLabel.text = "" /**************************/
        priceLabel.sizeToFit()
        priceLabel.isHidden = true
        
        
        bitcoin.frame.size = CGSize(width: 175, height: 175)
        bitcoin.center = view.center
        
        animateBitcoin()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // changeLabel.isHidden = true /**************************/
        
        priceLabel.text = ""
        
        AUD.isHidden = true
        BRL.isHidden = true
        CAD.isHidden = true
        CNY.isHidden = true
        EUR.isHidden = true
        GBP.isHidden = true
        HKD.isHidden = true
        IDR.isHidden = true
        ILS.isHidden = true
        INR.isHidden = true
        JPY.isHidden = true
        MXN.isHidden = true
        NOK.isHidden = true
        NZD.isHidden = true
        PLN.isHidden = true
        RON.isHidden = true
        RUB.isHidden = true
        SEK.isHidden = true
        SGD.isHidden = true
        USD.isHidden = true
        ZAR.isHidden = true
        print(priceLabel.font)
        priceLabel.sizeToFit()
        priceLabel.isHidden = true
        changeLabel.sizeToFit()
        
    }
    
    func animateBitcoin() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: "easeIn")
        rotateAnimation.fromValue = CGFloat.pi
        rotateAnimation.toValue = 0
        rotateAnimation.isAdditive = true
        
        rotateAnimation.duration = 2.0
        
        
        
        // let π : CGFloat = (CGFloat.pi * 2)
        
        let duration : Double = 0.25
        let delay : Double = duration / 2
        UIView.animate(withDuration: 2, delay: 0.0, options: .curveEaseIn, animations: {
            //            UIView.animate(withDuration: 0.1) { () -> Void in
            //                self.bitcoin.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            //            }
            //            UIView.animate(withDuration: 0.1, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            //                self.bitcoin.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat.pi * 2))
            //            }, completion: nil)
            self.bitcoin.frame.size.height = self.bitcoinHeight
            self.bitcoin.frame.size.width = self.bitcoinWidth
            self.bitcoin.frame.origin.x = self.bitcoinX
            self.bitcoin.frame.origin.y = self.bitcoinY
            //   self.bitcoin.layer.add(rotateAnimation, forKey: "rotate")
            //self.bitcoin.transform = CGAffineTransform(rotationAngle: CGFloat.pi).concatenating(CGAffineTransform(rotationAngle: (CGFloat.pi * 2)))
            //self.bitcoin.rotate360Degrees()
            // infiniteRotateSpinningView(self.bitcoin)
            UIView.animate(withDuration: duration) { () -> Void in
                self.bitcoin.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
            
            UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                self.bitcoin.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
            }, completion: nil)
            //            self.bitcoin.transform.rotated(by: 390)
            //self.bitcoin.transform = CGAffineTransform(rotationAngle: (CGFloat.pi * 2))
            
        }){ finished in
            if finished {
                self.BTC.frame.origin.x = self.centerLocation
                UIView.animate(withDuration: 2.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseInOut, animations: { //(withDuration: 2, delay: 0.4, options: .curveEaseInOut, animations: {
                    self.BTC.alpha = 1
                    self.reloadButton.alpha = 1
                    
                    
                }, completion: nil)
                UIView.animate(withDuration: 2.5, delay: 0.7, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseInOut, animations: { //(withDuration: 2, delay: 0.4, options: .curveEaseInOut, animations: {
                    
                    self.currencyPicker.alpha = 1
                    
                }, completion: { (completed: Bool) in
                    if completed == true {
                        self.arrow.isHidden = false
                        
                    }
                })
            }
        }
    }
    
    
    
    
    //TODO: Place your 3 UIPickerView delegate methods here (every thing needed to conform to the UIPickerViewDelegate protocol)
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: currencyArray[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        return attributedString
    }
    
    
    func arrayTakeMid(_ array: [UIImageView], _ row: Int) -> [UIImageView] {
        //let array = [AUD, BRL, CAD, CNY, EUR, GBP, HKD, IDR, ILS, INR, JPY, MXN, NOK, NZD, PLN, RON, RUB, SEK, SGD, USD, ZAR]
        
        let array1 : [UIImageView] = [UIImageView](array.prefix(row) + array.dropFirst(row+1))
        return array1
        
        // array2.remove(at: row)
    }
    // This will get called every time the picker is scrolled
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentRow = row
        
        finalURL = baseURL + currencyArray[row]
        //
        
        
        //        let hideArray
        if row > 0 {
            
            currentDisplayRow = row
            currencyIconFadeScaleAnimation(currentRow: row)
            //currencyIconAnimation(currentRow: row)
            currencySelected = currencySymbolsArray[row - 1]
            priceLabel.isHidden = false
            
            getSpecificBitcoinDataCompletion(url: finalURL, requestedData: "[ask]", currencySelected: currencySelected) { (isSuccess: Bool, data: String) in
                if isSuccess == true {
                    
                    self.priceLabel.text = data
                    
                } else {
                    
                    self.priceLabel.text = data
                }
            }
            getSpecificBitcoinDataCompletion(url: finalURL, requestedData: "[changes][percent][day]", currencySelected: currencySelected){ (isSuccess: Bool, data: String) in
                if isSuccess == true {
                    
                    if data.first == "-" {
                        self.changeLabel.text = "▼" + data.dropFirst()
                        self.changeLabel.textColor = self.negativeColour
                    } else {
                        self.changeLabel.text = "▲" + data
                        self.changeLabel.textColor = self.positiveColour
                    }
                    
                } else {
                    self.changeLabel.text = data
                }
                
            }
            
            //            getPercentData(url: finalURL)
            
            
            
            
            //            changeLabel.isHidden = false
            //            getPercentData(url: finalURL)
            
            //            changeLabel.isHidden = false /**************************/
            //            setPercentLabel(url: finalURL, label: changeLabel) /**************************/
            
            //    changeLabel.text = "FUCK%"
            //            changeLabel.textColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        }
        
    }
    
    @IBAction func reloadData(_ sender: Any) {
        if currentRow > 0 {
            reloadButtonUpdate(row: currentRow)
        } else {
            if currentDisplayRow != 0 {
                reloadButtonUpdate(row: currentDisplayRow)
            }
        }
    }
    func reloadButtonUpdate(row: Int) {
        spin(with: .curveLinear)
        startSpin()
        let reloadURL = baseURL + currencyArray[row]
        currencySelected = currencySymbolsArray[row - 1]
        priceLabel.isHidden = false
        
        getSpecificBitcoinDataCompletion(url: reloadURL, requestedData: "[ask]", currencySelected: currencySelected) { (isSuccess: Bool, data: String) in
            if isSuccess == true {
                
                self.priceLabel.text = data
                self.stopSpin()
            } else {
                self.priceLabel.text = data
                self.stopSpin()
            }
        }
        getSpecificBitcoinDataCompletion(url: reloadURL, requestedData: "[changes][percent][day]", currencySelected: currencySelected){ (isSuccess: Bool, data: String) in
            if isSuccess == true {
                
                if data.first == "-" {
                    self.changeLabel.text = "▼" + data.dropFirst()
                    self.changeLabel.textColor = self.negativeColour
                    self.stopSpin()
                } else {
                    self.changeLabel.text = "▲" + data
                    self.changeLabel.textColor = self.positiveColour
                    self.stopSpin()
                }
                
            } else {
                self.changeLabel.text = data
            }
            
        }
        
    }
    
    
    /****************************************************************************/
    //MARK: - Spin animation
    
    var animating = false
    
    func spin(with options: UIViewAnimationOptions) {
        // this spin completes 360 degrees every 2 seconds
        UIView.animate(withDuration: 0.5, delay: 0, options: options, animations: {() -> Void in
            self.reloadButton.transform = self.reloadButton.transform.rotated(by: .pi / 2)
        }, completion: {(_ finished: Bool) -> Void in
            if finished {
                if self.animating {
                    // if flag still set, keep spinning with constant speed
                    self.spin(with: .curveLinear)
                }
                else if options != .curveEaseOut {
                    // one last spin, with deceleration
                    self.spin(with: .curveEaseOut)
                }
            }
        })
    }
    func startSpin() {
        if !animating {
            animating = true
            spin(with: .curveEaseIn)
        }
    }
    
    func stopSpin() {
        // set the flag to stop spinning after one last 90 degree increment
        animating = false
    }
    
    

/*******************************************************************************************/
    
    
    //MARK: - Currency Icon Animation (V1)
    /***************************************************************/
    func returnIcon(iconArray: [UIImageView], currentRow: Int) -> UIImageView {
        return iconArray[currentRow - 1]
    }
    
    func currencyIconAnimation(currentRow: Int) {
        let animationOption : UIViewAnimationOptions = .curveEaseInOut
        
        
        if currentRow != 0 {
            let icons = [AUD, BRL, CAD, CNY, EUR, GBP, HKD, IDR, ILS, INR, JPY, MXN, NOK, NZD, PLN, RON, RUB, SEK, SGD, USD, ZAR]
            let theCurrentIcon = returnIcon(iconArray: [AUD, BRL, CAD, CNY, EUR, GBP, HKD, IDR, ILS, INR, JPY, MXN, NOK, NZD, PLN, RON, RUB, SEK, SGD, USD, ZAR], currentRow: currentRow)
        let currentIcon = theCurrentIcon
            
            currentIcon.isHidden = true
            var array2 : [UIImageView] = []
            for num in 1...icons.count {
                if currentIcon != icons[num - 1] {
                    array2.append(icons[num - 1]!)
                }
            }
            //            for num in 1...array2.count {
            //                array2[num - 1].frame.origin.x = centerLocation
            //            }
            if BTC.frame.origin.x == centerLocation {
                currentIcon.isHidden = false
                UIView.animate(withDuration: 1.5, delay: 0.2, options: animationOption, animations: {
                    self.BTC.frame.origin.x = self.btcLocationX
                    currentIcon.frame.origin.x = self.currencyLocationX
                }, completion: nil)
                
                previousIcon = currentIcon
                
            } else {
                
                UIView.animate(withDuration: 1.5, delay: 0.0, options: animationOption, animations: {
                    self.BTC.frame.origin.x = self.centerLocation
                    self.previousIcon?.frame.origin.x = self.centerLocation
                    
                }, completion: { finished in
                    if finished {
                        self.previousIcon?.isHidden = true
                        currentIcon.frame.origin.x = self.centerLocation
                        currentIcon.isHidden = false
                        for num in 1...array2.count {
                            array2[num - 1].isHidden = true
                        }
                        UIView.animate(withDuration: 1.5, delay: 0.02, options: animationOption, animations: {
                            self.BTC.frame.origin.x = self.btcLocationX
                            currentIcon.frame.origin.x = self.currencyLocationX
                            
                        }, completion: nil)
                        self.previousIcon? = currentIcon
                    }
                })
            }
        }
        
        
    }
    

    func currencyIconFadeScaleAnimation(currentRow: Int) {
        let icons = [AUD, BRL, CAD, CNY, EUR, GBP, HKD, IDR, ILS, INR, JPY, MXN, NOK, NZD, PLN, RON, RUB, SEK, SGD, USD, ZAR]
        
        if BTC.frame.origin.x == centerLocation {
            icons[currentRow - 1]?.isHidden = false
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut, animations: {
                icons[currentRow - 1]?.frame.origin.x = self.currencyLocationX
                self.BTC.frame.origin.x = self.btcLocationX
            }, completion: nil)
            
        } else {
            
            if AUD.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.AUD.frame.size.width -= 50
                    self.AUD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.AUD.frame.origin.y -= 30
                    self.AUD.frame.origin.x += 25
                    self.AUD.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.AUD.frame.origin.x = self.smallX
                        self.AUD.frame.origin.y = self.smallY
                    }
                }
                
            } else if BRL.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.BRL.frame.size.width -= 50
                    self.BRL.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.BRL.frame.origin.y -= 30
                    self.BRL.frame.origin.x += 25
                    self.BRL.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.BRL.frame.origin.x = self.smallX
                        self.BRL.frame.origin.y = self.smallY
                    }
                }
                
            } else if CAD.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.CAD.frame.size.width -= 50
                    self.CAD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.CAD.frame.origin.y -= 30
                    self.CAD.frame.origin.x += 25
                    self.CAD.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.CAD.frame.origin.x = self.smallX
                        self.CAD.frame.origin.y = self.smallY
                    }
                }
                
            } else if CNY.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.CNY.frame.size.width -= 50
                    self.CNY.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.CNY.frame.origin.y -= 30
                    self.CNY.frame.origin.x += 25
                    self.CNY.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.CNY.frame.origin.x = self.smallX
                        self.CNY.frame.origin.y = self.smallY
                    }
                }
                
            } else if EUR.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.EUR.frame.size.width -= 50
                    self.EUR.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.EUR.frame.origin.y -= 30
                    self.EUR.frame.origin.x += 25
                    self.EUR.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.EUR.frame.origin.x = self.smallX
                        self.EUR.frame.origin.y = self.smallY
                    }
                }
                
            } else if GBP.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.GBP.frame.size.width -= 50
                    self.GBP.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.GBP.frame.origin.y -= 30
                    self.GBP.frame.origin.x += 25
                    self.GBP.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.GBP.frame.origin.x = self.smallX
                        self.GBP.frame.origin.y = self.smallY
                    }
                }
                
            } else if HKD.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.HKD.frame.size.width -= 50
                    self.HKD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.HKD.frame.origin.y -= 30
                    self.HKD.frame.origin.x += 25
                    self.HKD.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.HKD.frame.origin.x = self.smallX
                        self.HKD.frame.origin.y = self.smallY
                    }
                }
                
            } else if IDR.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.IDR.frame.size.width -= 50
                    self.IDR.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.IDR.frame.origin.y -= 30
                    self.IDR.frame.origin.x += 25
                    self.IDR.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.IDR.frame.origin.x = self.smallX
                        self.IDR.frame.origin.y = self.smallY
                    }
                }
                
            } else if ILS.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.ILS.frame.size.width -= 50
                    self.ILS.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.ILS.frame.origin.y -= 30
                    self.ILS.frame.origin.x += 25
                    self.ILS.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.ILS.frame.origin.x = self.smallX
                        self.ILS.frame.origin.y = self.smallY
                    }
                }
                
            } else if INR.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.INR.frame.size.width -= 50
                    self.INR.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.INR.frame.origin.y -= 30
                    self.INR.frame.origin.x += 25
                    self.INR.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.INR.frame.origin.x = self.smallX
                        self.INR.frame.origin.y = self.smallY
                    }
                }
                
            } else if JPY.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.JPY.frame.size.width -= 50
                    self.JPY.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.JPY.frame.origin.y -= 30
                    self.JPY.frame.origin.x += 25
                    self.JPY.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.JPY.frame.origin.x = self.smallX
                        self.JPY.frame.origin.y = self.smallY
                    }
                }
                
            } else if MXN.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.MXN.frame.size.width -= 50
                    self.MXN.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.MXN.frame.origin.y -= 30
                    self.MXN.frame.origin.x += 25
                    self.MXN.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.MXN.frame.origin.x = self.smallX
                        self.MXN.frame.origin.y = self.smallY
                    }
                }
                
            } else if NOK.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.NOK.frame.size.width -= 50
                    self.NOK.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.NOK.frame.origin.y -= 30
                    self.NOK.frame.origin.x += 25
                    self.NOK.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.NOK.frame.origin.x = self.smallX
                        self.NOK.frame.origin.y = self.smallY
                    }
                }
                
            } else if NZD.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.NZD.frame.size.width -= 50
                    self.NZD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.NZD.frame.origin.y -= 30
                    self.NZD.frame.origin.x += 25
                    self.NZD.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.NZD.frame.origin.x = self.smallX
                        self.NZD.frame.origin.y = self.smallY
                    }
                }
                
            } else if PLN.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.PLN.frame.size.width -= 50
                    self.PLN.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.PLN.frame.origin.y -= 30
                    self.PLN.frame.origin.x += 25
                    self.PLN.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.PLN.frame.origin.x = self.smallX
                        self.PLN.frame.origin.y = self.smallY
                    }
                }
                
            } else if RON.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.RON.frame.size.width -= 50
                    self.RON.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.RON.frame.origin.y -= 30
                    self.RON.frame.origin.x += 25
                    self.RON.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.RON.frame.origin.x = self.smallX
                        self.RON.frame.origin.y = self.smallY
                    }
                }
                
            } else if RUB.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.RUB.frame.size.width -= 50
                    self.RUB.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.RUB.frame.origin.y -= 30
                    self.RUB.frame.origin.x += 25
                    self.RUB.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.RUB.frame.origin.x = self.smallX
                        self.RUB.frame.origin.y = self.smallY
                    }
                }
                
            } else if SEK.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.SEK.frame.size.width -= 50
                    self.SEK.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.SEK.frame.origin.y -= 30
                    self.SEK.frame.origin.x += 25
                    self.SEK.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.SEK.frame.origin.x = self.smallX
                        self.SEK.frame.origin.y = self.smallY
                    }
                }
                
            } else if SGD.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.SGD.frame.size.width -= 50
                    self.SGD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.SGD.frame.origin.y -= 30
                    self.SGD.frame.origin.x += 25
                    self.SGD.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.SGD.frame.origin.x = self.smallX
                        self.SGD.frame.origin.y = self.smallY
                    }
                }
                
            } else if USD.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.USD.frame.size.width -= 50
                    self.USD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.USD.frame.origin.y -= 30
                    self.USD.frame.origin.x += 25
                    self.USD.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.USD.frame.origin.x = self.smallX
                        self.USD.frame.origin.y = self.smallY
                    }
                }
                
            } else if ZAR.isHidden == false {
                icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
                icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
                icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
                icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
                icons[currentRow - 1]?.alpha = 0.0
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                    self.ZAR.frame.size.width -= 50
                    self.ZAR.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                    self.ZAR.frame.origin.y -= 30
                    self.ZAR.frame.origin.x += 25
                    self.ZAR.alpha = 0.0
                    icons[currentRow - 1]?.frame.size.width += 50
                    icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                    icons[currentRow - 1]?.frame.origin.y += 30
                    icons[currentRow - 1]?.frame.origin.x -= 25
                    icons[currentRow - 1]?.alpha = 1.0
                }) { finished in
                    if finished {
                        self.ZAR.frame.origin.x = self.smallX
                        self.ZAR.frame.origin.y = self.smallY
                    }
                }
                
            }
        }
     //   icon[currentRow - 1]
  
        
        
    }
    
    
    

} // End of ViewController Class



/*
 
 if AUD.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.AUD.frame.size.width -= 50
 self.AUD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.AUD.frame.origin.y -= 30
 self.AUD.frame.origin.x += 25
 self.AUD.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.AUD.frame.origin.x = self.smallX
 self.AUD.frame.origin.y = self.smallY
 }
 }
 
 } else if BRL.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.BRL.frame.size.width -= 50
 self.BRL.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.BRL.frame.origin.y -= 30
 self.BRL.frame.origin.x += 25
 self.BRL.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.BRL.frame.origin.x = self.smallX
 self.BRL.frame.origin.y = self.smallY
 }
 }
 
 } else if CAD.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.CAD.frame.size.width -= 50
 self.CAD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.CAD.frame.origin.y -= 30
 self.CAD.frame.origin.x += 25
 self.CAD.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.CAD.frame.origin.x = self.smallX
 self.CAD.frame.origin.y = self.smallY
 }
 }
 
 } else if CNY.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.CNY.frame.size.width -= 50
 self.CNY.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.CNY.frame.origin.y -= 30
 self.CNY.frame.origin.x += 25
 self.CNY.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.CNY.frame.origin.x = self.smallX
 self.CNY.frame.origin.y = self.smallY
 }
 }
 
 } else if EUR.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.EUR.frame.size.width -= 50
 self.EUR.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.EUR.frame.origin.y -= 30
 self.EUR.frame.origin.x += 25
 self.EUR.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.EUR.frame.origin.x = self.smallX
 self.EUR.frame.origin.y = self.smallY
 }
 }
 
 } else if GBP.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.GBP.frame.size.width -= 50
 self.GBP.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.GBP.frame.origin.y -= 30
 self.GBP.frame.origin.x += 25
 self.GBP.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.GBP.frame.origin.x = self.smallX
 self.GBP.frame.origin.y = self.smallY
 }
 }
 
 } else if HKD.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.HKD.frame.size.width -= 50
 self.HKD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.HKD.frame.origin.y -= 30
 self.HKD.frame.origin.x += 25
 self.HKD.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.HKD.frame.origin.x = self.smallX
 self.HKD.frame.origin.y = self.smallY
 }
 }
 
 } else if IDR.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.IDR.frame.size.width -= 50
 self.IDR.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.IDR.frame.origin.y -= 30
 self.IDR.frame.origin.x += 25
 self.IDR.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.IDR.frame.origin.x = self.smallX
 self.IDR.frame.origin.y = self.smallY
 }
 }
 
 } else if ILS.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.ILS.frame.size.width -= 50
 self.ILS.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.ILS.frame.origin.y -= 30
 self.ILS.frame.origin.x += 25
 self.ILS.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.ILS.frame.origin.x = self.smallX
 self.ILS.frame.origin.y = self.smallY
 }
 }
 
 } else if INR.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.INR.frame.size.width -= 50
 self.INR.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.INR.frame.origin.y -= 30
 self.INR.frame.origin.x += 25
 self.INR.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.INR.frame.origin.x = self.smallX
 self.INR.frame.origin.y = self.smallY
 }
 }
 
 } else if JPY.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.JPY.frame.size.width -= 50
 self.JPY.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.JPY.frame.origin.y -= 30
 self.JPY.frame.origin.x += 25
 self.JPY.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.JPY.frame.origin.x = self.smallX
 self.JPY.frame.origin.y = self.smallY
 }
 }
 
 } else if MXN.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.MXN.frame.size.width -= 50
 self.MXN.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.MXN.frame.origin.y -= 30
 self.MXN.frame.origin.x += 25
 self.MXN.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.MXN.frame.origin.x = self.smallX
 self.MXN.frame.origin.y = self.smallY
 }
 }
 
 } else if NOK.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.NOK.frame.size.width -= 50
 self.NOK.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.NOK.frame.origin.y -= 30
 self.NOK.frame.origin.x += 25
 self.NOK.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.NOK.frame.origin.x = self.smallX
 self.NOK.frame.origin.y = self.smallY
 }
 }
 
 } else if NZD.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.NZD.frame.size.width -= 50
 self.NZD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.NZD.frame.origin.y -= 30
 self.NZD.frame.origin.x += 25
 self.NZD.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.NZD.frame.origin.x = self.smallX
 self.NZD.frame.origin.y = self.smallY
 }
 }
 
 } else if PLN.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.PLN.frame.size.width -= 50
 self.PLN.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.PLN.frame.origin.y -= 30
 self.PLN.frame.origin.x += 25
 self.PLN.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.PLN.frame.origin.x = self.smallX
 self.PLN.frame.origin.y = self.smallY
 }
 }
 
 } else if RON.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.RON.frame.size.width -= 50
 self.RON.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.RON.frame.origin.y -= 30
 self.RON.frame.origin.x += 25
 self.RON.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.RON.frame.origin.x = self.smallX
 self.RON.frame.origin.y = self.smallY
 }
 }
 
 } else if RUB.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.RUB.frame.size.width -= 50
 self.RUB.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.RUB.frame.origin.y -= 30
 self.RUB.frame.origin.x += 25
 self.RUB.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.RUB.frame.origin.x = self.smallX
 self.RUB.frame.origin.y = self.smallY
 }
 }
 
 } else if SEK.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.SEK.frame.size.width -= 50
 self.SEK.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.SEK.frame.origin.y -= 30
 self.SEK.frame.origin.x += 25
 self.SEK.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.SEK.frame.origin.x = self.smallX
 self.SEK.frame.origin.y = self.smallY
 }
 }
 
 } else if SGD.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.SGD.frame.size.width -= 50
 self.SGD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.SGD.frame.origin.y -= 30
 self.SGD.frame.origin.x += 25
 self.SGD.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.SGD.frame.origin.x = self.smallX
 self.SGD.frame.origin.y = self.smallY
 }
 }
 
 } else if USD.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.USD.frame.size.width -= 50
 self.USD.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.USD.frame.origin.y -= 30
 self.USD.frame.origin.x += 25
 self.USD.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.USD.frame.origin.x = self.smallX
 self.USD.frame.origin.y = self.smallY
 }
 }
 
 } else if ZAR.isHidden == false {
 icons[currentRow - 1]?.frame.size.width = currencyWidth - 50
 icons[currentRow - 1]?.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
 icons[currentRow - 1]?.frame.origin.y = currencyLocationY - 30
 icons[currentRow - 1]?.frame.origin.x = currencyLocationX + 25
 icons[currentRow - 1]?.alpha = 0.0
 UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
 self.ZAR.frame.size.width -= 50
 self.ZAR.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
 self.ZAR.frame.origin.y -= 30
 self.ZAR.frame.origin.x += 25
 self.ZAR.alpha = 0.0
 icons[currentRow - 1]?.frame.size.width += 50
 icons[currentRow - 1]?.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
 icons[currentRow - 1]?.frame.origin.y += 30
 icons[currentRow - 1]?.frame.origin.x -= 25
 icons[currentRow - 1]?.alpha = 1.0
 }) { finished in
 if finished {
 self.ZAR.frame.origin.x = self.smallX
 self.ZAR.frame.origin.y = self.smallY
 }
 }
 
 }
 
 
 
*/
