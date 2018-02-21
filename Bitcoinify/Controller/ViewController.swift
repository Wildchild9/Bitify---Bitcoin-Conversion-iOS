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
import ScrollableGraphView

class IconState {
    var icon = UIImageView()
    var iconRow : Int = 0
    static let lastIcon = IconState() // This is a singleton; it is accessible across all classes and objects
    
}
class ReloadState {
     var canReload : Bool = false
    static let reload = ReloadState() // This is a singleton
}
class CurrentRow {
    var number : Int = 0
    static let row = CurrentRow() // This is a singleton
}

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, ScrollableGraphViewDataSource {
    
    
/***********************************************/
//MARK: - Class-Wide Values
    
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
    var iconArray : [UIImageView] = []
    var iconArrayBTC : [UIImageView] = []
    var centerLocation : CGFloat = 0
    var currentRow : Int = 0
    var currentDisplayRow : Int = 0
    var smallWidth : CGFloat = 0//btcWidth - 50
    var smallHeight : CGFloat = 0//btcHeight - (50 * (self.btcHeight / self.btcWidth))
    var smallY : CGFloat = 0//currencyLocationY - 30
    var smallX : CGFloat = 0//currencyLocationX + 25
   
    
    
    
    
/***********************************************/
//MARK: - @IBOutlets
    
    @IBOutlet weak var reloadButton: UIButton!
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
    @IBOutlet weak var bitcoinLogoContainer: UIView!
    
//TODO - Graph Values & @IBOutlets
    
    let dates = Dates()
    let graphBaseURL = "https://api.coindesk.com/v1/bpi/historical/close.json?start="
    let midURL = "&end="
    let format = DateFormatter()
    var numberOfDates : Int = 0
    var arrayOfDates : [String] = []
    var valuesArray : [Double] = []
    let yesterday = Calendar.current.date(byAdding: .day, value: 0, to: Date())
    let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())
    let weekAgoDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())
    var priceNow : Double = 0
    var quarter1 : Double = 0
    var half : Double = 0
    var quarter3 : Double = 0
    var whole : Double = 0
    
    @IBOutlet weak var graph: ScrollableGraphView!
    @IBOutlet weak var dateStack: UIStackView!
    @IBOutlet weak var dateLabel1: UILabel!
    @IBOutlet weak var dateLabel2: UILabel!
    @IBOutlet weak var dateLabel3: UILabel!
    @IBOutlet weak var dateLabel4: UILabel!
    @IBOutlet weak var dateLabel5: UILabel!
    @IBOutlet weak var dateLabel6: UILabel!
    @IBOutlet weak var dateLabel7: UILabel!
    @IBOutlet weak var graphContainer: UIView!
    
    
    
/***********************************************/
//MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bitcoin.center = bitcoinLogoContainer.center
        dateLabel1.alpha = 0
        dateLabel2.alpha = 0
        dateLabel3.alpha = 0
        dateLabel4.alpha = 0
        dateLabel5.alpha = 0
        dateLabel6.alpha = 0
        dateLabel7.alpha = 0
        priceLabel.textColor = .mint
        graph.isHidden = true
        
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
        
        bitcoin.frame.size = CGSize(width: 175, height: 175)
        bitcoin.center = view.center
        
        ReloadState.reload.canReload = false
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        changeLabel.text = ""
        
        
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
        
    currencyPicker.backgroundColor?.withAlphaComponent(0.0)
        
        AUD.alpha = 0.0
        BRL.alpha = 0.0
        CAD.alpha = 0.0
        CNY.alpha = 0.0
        EUR.alpha = 0.0
        GBP.alpha = 0.0
        HKD.alpha = 0.0
        IDR.alpha = 0.0
        ILS.alpha = 0.0
        INR.alpha = 0.0
        JPY.alpha = 0.0
        MXN.alpha = 0.0
        NOK.alpha = 0.0
        NZD.alpha = 0.0
        PLN.alpha = 0.0
        RON.alpha = 0.0
        RUB.alpha = 0.0
        SEK.alpha = 0.0
        SGD.alpha = 0.0
        USD.alpha = 0.0
        ZAR.alpha = 0.0
        BTC.frame.origin.x = centerLocation
        
        smallWidth = btcWidth - 50
        smallHeight = btcHeight - (50 * (self.btcHeight / self.btcWidth))
        smallY = currencyLocationY - 30
        smallX = currencyLocationX + 25
        
        BTC.alpha = 0
        currencyPicker.alpha = 0
        reloadButton.alpha = 0
        arrow.isHidden = true
      
        changeLabel.alpha = 0
        
        priceLabel.sizeToFit()
        priceLabel.isHidden = true
        
    }
    
    
    
//MARK: - viewDidAppear
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bitcoin.frame.size = CGSize(width: 175, height: 175)
        bitcoin.center = view.center
        animateBitcoin()
        priceLabel.text = ""
        
        AUD.alpha = 0.0
        BRL.alpha = 0.0
        CAD.alpha = 0.0
        CNY.alpha = 0.0
        EUR.alpha = 0.0
        GBP.alpha = 0.0
        HKD.alpha = 0.0
        IDR.alpha = 0.0
        ILS.alpha = 0.0
        INR.alpha = 0.0
        JPY.alpha = 0.0
        MXN.alpha = 0.0
        NOK.alpha = 0.0
        NZD.alpha = 0.0
        PLN.alpha = 0.0
        RON.alpha = 0.0
        RUB.alpha = 0.0
        SEK.alpha = 0.0
        SGD.alpha = 0.0
        USD.alpha = 0.0
        ZAR.alpha = 0.0
        print(priceLabel.font)
        priceLabel.sizeToFit()
        priceLabel.isHidden = true
        changeLabel.sizeToFit()
        
    }
    
    
    
    
    
/***************************************************************/
    
//MARK: - UIPickerView Delegate Methods
    
    
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
        let attributedString = NSAttributedString(string: currencyArray[row], attributes: [NSAttributedStringKey.foregroundColor: UIColor.mint])
        return attributedString
    }
    
    // This will get called every time the picker is scrolled
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentRow = row
        CurrentRow.row.number = row
        finalURL = baseURL + currencyArray[row]
 
        if row > 0 {
            currentDisplayRow = row
            currencySelected = currencySymbolsArray[row - 1]
            
            currencyIconFadeScaleAnimation(currentRow: row)
            
            
            
            updateInterfaceForPickerview(finalURL: finalURL, currencySelected: currencySelected)
        }
    }
    
    
    
    
    
    
/***************************************************************/
//MARK: - ScrollableGraphView Data Source Methods
    
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double { // Final Values
        return valuesArray[pointIndex]
    }
    
    func label(atIndex pointIndex: Int) -> String { // x-axis labels
        
        // We return a value at all because the current setup of the date labels need the space that is otherwise given to our (blank) labels
        
        return " "
    }
    
    func numberOfPoints() -> Int { // Number of data points on graph
        
        return numberOfDates
    }
    
    
    
    
    
    //TODO: - Consider integrating the pod 'PKHUD' to deal with errors on the UI's front
    
    

    
/***************************************************************/
//MARK: - Update User Interface for UIPickerView Function
    
    func updateInterfaceForPickerview(finalURL: String, currencySelected: String) {
        priceLabel.isHidden = false
        changeLabel.isHidden = false
        getSpecificBitcoinDataCompletion(url: finalURL, requestedData: "[ask]", currencySelected: currencySelected) { (isSuccess: Bool, data: String) in
            if isSuccess == true {
                let priceData = data
                
                getSpecificBitcoinDataCompletion(url: finalURL, requestedData: "[changes][percent][day]", currencySelected: currencySelected){ (isSuccess: Bool, data: String) in
                    if isSuccess == true {
                        self.priceLabel.text = priceData
                        if data.first == "-" {
                            self.changeLabel.text = "▼" + data.dropFirst()
                            self.changeLabel.textColor = self.negativeColour
                            if self.changeLabel.alpha == 0 {
                                self.fadeInLabel(label: self.changeLabel)
                            }
                        } else {
                            self.changeLabel.text = "▲" + data
                            self.changeLabel.textColor = self.positiveColour
                            if self.changeLabel.alpha == 0 {
                                self.fadeInLabel(label: self.changeLabel)
                            }
                        }
                    } else {
                        print("Error when getting percent label data (not price label)")
                    }
                }
                
                
            } else {
                self.priceLabel.text = "Price Unavailable"
                self.fadeOutLabel(label: self.changeLabel)
            }
        }
        
    }
    
    
    
    
/***************************************************************/
//MARK: - Reload Button Action
    
    @IBAction func reloadData(_ sender: Any) {
        
        if CurrentRow.row.number == 0 && ReloadState.reload.canReload == true {
            spin(with: .curveLinear)
            startSpin()
            print(IconState.lastIcon.iconRow)
            reloadData(row: IconState.lastIcon.iconRow) { isComplete in
                if isComplete {
                    self.stopSpin()
                }
                
            }
        } else if currentRow > 0 && currentDisplayRow != 0 {
            spin(with: .curveLinear)
            startSpin()
            reloadData(row: currentRow) { isComplete in
                if isComplete {
                    self.stopSpin()
                }
                
            }
            
        }
    }
    
    
    
    
    
    
    
/***************************************************************/
//MARK: - Reload Data Function
    func reloadData(row: Int, completion: ((Bool) -> Void)? = nil) {
        priceLabel.isHidden = false
        changeLabel.isHidden = false
        let reloadURL = baseURL + currencyArray[row]
        currencySelected = currencySymbolsArray[row - 1]
        priceLabel.isHidden = false
        
        getSpecificBitcoinDataCompletion(url: reloadURL, requestedData: "[ask]", currencySelected: currencySelected) { (isSuccess: Bool, data: String) in
            if isSuccess == true {
                let priceData = data
                
                getSpecificBitcoinDataCompletion(url: reloadURL, requestedData: "[changes][percent][day]", currencySelected: self.currencySelected){ (isSuccess: Bool, data: String) in
                    if isSuccess == true {
                        self.priceLabel.text = priceData
                        if data.first == "-" {
                            self.changeLabel.text = "▼" + data.dropFirst()
                            self.changeLabel.textColor = self.negativeColour
                            if self.changeLabel.alpha == 0 {
                                self.fadeInLabel(label: self.changeLabel)
                            }
                        } else {
                            self.changeLabel.text = "▲" + data
                            self.changeLabel.textColor = self.positiveColour
                            if self.changeLabel.alpha == 0 {
                                self.fadeInLabel(label: self.changeLabel)
                            }
                        }
                        
                        let isComplete = true
                        print("\nReload Data Successful!\n")
                        completion?(isComplete)
                        
                        
                    } else {
                        print("Error when getting percent label data (not price label)")
                        let isComplete = false
                        print("\nReload Data Unsuccessful!\n")
                        completion?(isComplete)
                        
                    }
                    
                }
                
               
            } else {
                self.priceLabel.text = "Price Unavailable"
                self.fadeOutLabel(label: self.changeLabel)
                let isComplete = false
                print("\nReload Data Unsuccessful!\n")
                completion?(isComplete)
                
            }
        }
        
    }

    
/****************************************************************************/
//MARK: - Quick Fade Animations for Percent Label (for reload)
    func fadeOutLabel(label: UILabel) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseIn, animations: {
            label.alpha = 0
        }) { finished in
            if finished {
                label.text = ""
                label.alpha = 1
            }
        }
    }
    func fadeInLabel(label: UILabel) {
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            label.alpha = 1
        }) { finished in
            if finished {
                label.alpha = 1
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
 
    
    
    
    
/****************************************************************************/
//MARK: - Initial Bitcoin Animation (Initialize Items to Appear After Bitcoin Animation [betwees *s])
    
    func animateBitcoin() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: "easeIn")
        rotateAnimation.fromValue = CGFloat.pi
        rotateAnimation.toValue = 0
        rotateAnimation.isAdditive = true
        
        rotateAnimation.duration = 2.0
        
        
        let duration : Double = 0.09
        let delay : Double = duration / 2
        UIView.animate(withDuration: 2, delay: 0.0, options: .curveEaseIn, animations: {
            
            self.bitcoin.frame.size.height = self.bitcoinHeight
            self.bitcoin.frame.size.width = self.bitcoinWidth
            self.bitcoin.frame.origin.x = self.bitcoinX
            self.bitcoin.frame.origin.y = self.bitcoinY
            
            UIView.animate(withDuration: duration) { () -> Void in
                self.bitcoin.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            }
            
            UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: { () -> Void in
                self.bitcoin.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
            }, completion: nil)
            //            self.bitcoin.transform.rotated(by: 390)
            //self.bitcoin.transform = CGAffineTransform(rotationAngle: (CGFloat.pi * 2))
            
        }){ finished in
            if finished {
                self.BTC.frame.origin.x = self.centerLocation
                self.setupGraph()
                UIView.animate(withDuration: 2.5, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseInOut, animations: { //(withDuration: 2, delay: 0.4, options: .curveEaseInOut, animations: {
                    self.BTC.alpha = 1
                    self.reloadButton.alpha = 1
                    
                    
                }, completion: nil)
                UIView.animate(withDuration: 2.5, delay: 0.65, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseInOut, animations: { //(withDuration: 2, delay: 0.4, options: .curveEaseInOut, animations: {
                    
                    self.currencyPicker.alpha = 1
                    
                }, completion: { (completed: Bool) in
 //********************
                    if completed == true {
                        self.arrow.isHidden = false
                        
                    }
 //********************
                })
            }
        }
    }
    
    
    
    
    
    
/****************************************************************************/
//MARK: - Currency Icon Fade & Scale Animation

    func currencyIconFadeScaleAnimation(currentRow: Int) {
        let icons = [AUD, BRL, CAD, CNY, EUR, GBP, HKD, IDR, ILS, INR, JPY, MXN, NOK, NZD, PLN, RON, RUB, SEK, SGD, USD, ZAR]
        
        let currentIcon = icons[currentRow - 1]!
        
        if BTC.frame.origin.x == centerLocation {
        IconState.lastIcon.icon = currentIcon
        IconState.lastIcon.iconRow = CurrentRow.row.number
            print(IconState.lastIcon.iconRow)
            currentIcon.frame.origin.x = BTC.frame.origin.x
            currentIcon.alpha = 1
            UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseInOut, animations: {
                currentIcon.frame.origin.x = self.currencyLocationX
                self.BTC.frame.origin.x =  self.btcLocationX
                self.changeLabel.alpha = 1
            }) { finished in
                if finished {
                    ReloadState.reload.canReload = true
                } else {
                    ReloadState.reload.canReload = true
                }
            }
            
        } else {
            ReloadState.reload.canReload = true
            singleCurrencyIconAnimation(currentIcon: currentIcon, previousIcon: IconState.lastIcon.icon, row: CurrentRow.row.number) { (isSuccess, rowNumber, setIcon) in
                if isSuccess {
                    IconState.lastIcon.icon = setIcon
                    IconState.lastIcon.iconRow = rowNumber
                }
            }
        }
    }
    
   
    
    
    
    
/****************************************************************************/
//MARK: - Single Currency Icon Animation
    
    func singleCurrencyIconAnimation(currentIcon: UIImageView, previousIcon: UIImageView, row: Int, completion: (Bool, Int, UIImageView) -> Void) {
        let rowNumber : Int = row
        if currentIcon != previousIcon {
            previousIcon.isHidden = false
            currentIcon.isHidden = false
            currentIcon.frame.size.width = currencyWidth - 50
            currentIcon.frame.size.height = currencyHeight - (50 * (currencyHeight / currencyWidth))
            currentIcon.frame.origin.y = currencyLocationY - 22.5
            currentIcon.frame.origin.x = currencyLocationX + 25
            currentIcon.alpha = 0.0
            UIView.animate(withDuration: 0.75, delay: 0.0, options: .curveEaseInOut, animations: {
                previousIcon.frame.size.width -= 50
                previousIcon.frame.size.height -= 50 * (self.btcHeight / self.btcWidth)
                previousIcon.frame.origin.y -= 22.5
                previousIcon.frame.origin.x += 25
                previousIcon.alpha = 0.0
                currentIcon.frame.size.width += 50
                currentIcon.frame.size.height += 50 * (self.btcHeight / self.btcWidth)
                currentIcon.frame.origin.y += 22.5
                currentIcon.frame.origin.x -= 25
                currentIcon.alpha = 1.0
            }) { finished in
                if finished {
                    previousIcon.frame.origin.x = self.smallX
                    previousIcon.frame.origin.y = self.smallY

                }
            }
        } else {
            reloadData(row: row, completion: nil)
        }
        let isSuccess = true
        let setIcon = currentIcon
        completion(isSuccess, rowNumber, setIcon)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
//MARK: - Graph Section
    
    
    func setupGraph() {
        graph.frame.origin = graphContainer.frame.origin
        dateLabel1.alpha = 0
        dateLabel2.alpha = 0
        dateLabel3.alpha = 0
        dateLabel4.alpha = 0
        dateLabel5.alpha = 0
        dateLabel6.alpha = 0
        dateLabel7.alpha = 0
        graph.isHidden = true
        let graphFinalURL = graphBaseURL + (weekAgoDate?.formattedDate())! + midURL + (yesterday?.formattedDate())!
        Dates.getDatesBetweenInterval(weekAgoDate!, yesterday!) { (finished, datesArray) in
            if finished {
                numberOfDates = datesArray.count + 1
                arrayOfDates = datesArray
                arrayOfDates.append(Date().formattedDate())
                print(datesArray)
                
                getBitcoinDateArrayData(url: graphFinalURL, dates: datesArray) { (isSuccess, datesValueArray) in
                    if isSuccess {
                        getBitcoinCurrentData { (isCompleted, currentPrice) in
                            if isCompleted {
                                self.graph.frame.origin = self.graphContainer.frame.origin
                                self.valuesArray = datesValueArray
                            
                                print("valuesArray without current price --> \(self.valuesArray)\n")
                                self.valuesArray.append(currentPrice)
                                print("valuesArray with current price --> \(self.valuesArray)\n")
                                self.quarter1 = self.valuesArray.max()! * 0.25
                                self.half = self.valuesArray.max()! * 0.5
                                self.quarter3 = self.valuesArray.max()! * 0.75
                                self.whole = self.valuesArray.max()!
                                print(self.whole)
                                
                                self.makeGraphView(graph: self.graph)
                                self.graph.frame.origin = self.graphContainer.frame.origin
                                self.graphContainer.bringSubview(toFront: self.graph)
                                self.graphContainer.bringSubview(toFront: self.dateStack)
                                
                                self.dateLabel1.text = self.arrayOfDates[0].monthDay()
                                self.dateLabel2.text = self.arrayOfDates[1].monthDay()
                                self.dateLabel3.text = self.arrayOfDates[2].monthDay()
                                self.dateLabel4.text = self.arrayOfDates[3].monthDay()
                                self.dateLabel5.text = self.arrayOfDates[4].monthDay()
                                self.dateLabel6.text = self.arrayOfDates[5].monthDay()
                                self.dateLabel7.text = self.arrayOfDates[6].monthDay()
                                
                                self.datesBuildAnimationWithDelay(delay: 0.2, animationOption: .curveEaseInOut, singleAnimationDuration: 1.0)
                                
                            } else {
                                print("Graph failed to load data")
                            }
                            
                            
                        }
                        
                    } else {
                        print("Graph failed to load data")
                    }
                }
                
                
                
            }
            
        }
    }
    
    func datesBuildAnimationWithDelay(delay: Double, animationOption: UIViewAnimationOptions, singleAnimationDuration: Double) {
        var startPause : Double = 0.0
        if delay > 0.75 {
            startPause = 0.75
        }
        UIView.animate(withDuration: singleAnimationDuration, delay: startPause, options: animationOption, animations: {
            self.dateLabel1.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: singleAnimationDuration, delay: startPause + delay, options: animationOption, animations: {
            self.dateLabel2.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: singleAnimationDuration, delay: startPause + (2 * delay), options: animationOption, animations: {
            self.dateLabel3.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: singleAnimationDuration, delay: startPause + (3 * delay), options: animationOption, animations: {
            self.dateLabel4.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: singleAnimationDuration, delay: startPause + (4 * delay), options: animationOption, animations: {
            self.dateLabel5.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: singleAnimationDuration, delay: startPause + (5 * delay), options: animationOption, animations: {
            self.dateLabel6.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: singleAnimationDuration, delay: startPause + (6 * delay), options: animationOption, animations: {
            self.dateLabel7.alpha = 1
        }, completion: nil)
    }
    
    func bringDateLabelsToFront() {
        dateLabel1.layer.zPosition = 1
        graphContainer.bringSubview(toFront: dateLabel1)
        dateLabel2.layer.zPosition = 1
        graphContainer.bringSubview(toFront: dateLabel2)
        dateLabel3.layer.zPosition = 1
        graphContainer.bringSubview(toFront: dateLabel3)
        dateLabel4.layer.zPosition = 1
        graphContainer.bringSubview(toFront: dateLabel4)
        dateLabel5.layer.zPosition = 1
        graphContainer.bringSubview(toFront: dateLabel5)
        dateLabel6.layer.zPosition = 1
        graphContainer.bringSubview(toFront: dateLabel6)
        dateLabel7.layer.zPosition = 1
        graphContainer.bringSubview(toFront: dateLabel7)
        dateStack.layer.zPosition = 1
        graphContainer.bringSubview(toFront: dateStack)
    }
    
    // Mark: - Make Graph Functions
    
    func makeGraphView(graph: ScrollableGraphView!) {
        let graphView = ScrollableGraphView(frame: graph.frame, dataSource: self as ScrollableGraphViewDataSource)
        
        let linePlot = LinePlot(identifier: "linePlot")
        let dotPlot = DotPlot(identifier: "dotPlot")
        let referenceLines = ReferenceLines()
        
        setupLinePlot(linePlot: linePlot, backgroundColour: .blackberry, lineColour: .mint)
        setupDotPlot(dotPlot: dotPlot, dataPointColour: .white)
        setupReferenceLines(referenceLines: referenceLines, dataPointColour: .white, referenceLineColour: .strawberry)
        setGraphViewAttributes(graphView: graphView)
        graphView.isUserInteractionEnabled = false
        
        finalizeGraph(graphView: graphView, linePlot: linePlot, dotPlot: dotPlot, referenceLines: referenceLines)
    }
    
    func setupLinePlot(linePlot: LinePlot, backgroundColour: UIColor, lineColour: UIColor) {
        linePlot.lineColor = lineColour // Line colour
        linePlot.lineWidth = 1.25 // Line width
        linePlot.lineStyle = ScrollableGraphViewLineStyle.smooth // Line Type
        linePlot.shouldFill = true // Line with fill? (Bool)
        linePlot.fillType = .gradient // Fill type
        linePlot.fillGradientStartColor = lineColour // Top gradient colour
        linePlot.fillGradientEndColor = backgroundColour // Bottom gradient colour
        linePlot.adaptAnimationType = .elastic // Line animation
        
        
    }
    
    func setupDotPlot(dotPlot: DotPlot, dataPointColour: UIColor) {
        dotPlot.dataPointSize = 2 // Dot size (norm 2)
        dotPlot.dataPointFillColor = dataPointColour // Dot colour
        dotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic // Dot animation
    }
    
    func setupReferenceLines(referenceLines: ReferenceLines, dataPointColour: UIColor, referenceLineColour: UIColor) {
        
        referenceLines.referenceLineColor = referenceLineColour.withAlphaComponent(0.2) // Colour and opacity of reference lines
        referenceLines.dataPointLabelColor = dataPointColour // Colour of x-axis labels
        referenceLines.referenceLineLabelColor = referenceLineColour // Colour of y-axis labels
        referenceLines.dataPointLabelFont = UIFont(name: "Futura-Medium", size: 12) // Font of x-axis labels
        referenceLines.referenceLineLabelFont = UIFont(name: "HelveticaNeue-CondensedBold", size: 12)! // Font of y-axis labels
        // HelveticaNeue-Medium
        
        
        // To utilize referenceLines.positionType, make sure that graphView.shouldAdaptRange is false
        referenceLines.positionType = .absolute // If type specidied, set referenceLines.includeMinMax to false
        referenceLines.absolutePositions = [0.0,quarter1,half,quarter3,whole]//[0,0.5,1]
        referenceLines.positionType = .absolute
        // absolute positions can be and number that fits within your data set
        // relative positions have to be a value from 0-1 (like percents)
        
        referenceLines.includeMinMax = false // Show min and max reference lines? (Bool)
        referenceLines.referenceLinePosition = .left // Position of y-axis labels
        referenceLines.referenceLineNumberStyle = NumberFormatter.Style.currency
        referenceLines.shouldShowLabels = true // Show y-axis labels? (Bool)    *******
        referenceLines.shouldShowReferenceLines = true // Show refernce lines? (Bool)
    }
    
    func setGraphViewAttributes(graphView: ScrollableGraphView) {
        graphView.backgroundFillColor = .clear // Background colour (above)
        graphView.backgroundColor = .clear // Background colour (below)
        graphView.rightmostPointPadding = 0 // CGFloat(valuesArray.last!)// Right spring padding space // 25
        graphView.leftmostPointPadding = 0 // Left spring padding space // 50
        
        graphView.rangeMax = whole // Sets the maximum value for the y-axis (essential to have, if deleted or commented out graph will most likely be incorrect)
        
        
        graphView.bottomMargin = 0 // Space between bottom edge of graph and x-axis
        graphView.shouldRangeAlwaysStartAtZero = true // Y-axis start at zero? (Bool)
        graphView.dataPointSpacing = graph.frame.size.width / CGFloat(valuesArray.count - 1)
        graphView.shouldAdaptRange = false // Should abide by minimum and maximum user-set values for y-axis
        // If false, this also ensures that the y-axis values will not change while in use
        
        //        if graphView.shouldAdaptRange == true {
        //            graphView.rangeMax = value // Max value for y-axis
        //            graphView.range = value // Min value for y-axis
        //        }
        graphView.shouldAnimateOnAdapt = true // Should utilize animations while using graph? (Bool)
        graphView.shouldAnimateOnStartup = true // Should animate building of graph? (Bool)
    }
    
    func finalizeGraph(graphView: ScrollableGraphView, linePlot: LinePlot?, dotPlot: DotPlot?, referenceLines: ReferenceLines?) {
        if linePlot != nil { // Only runs if a linePlot is set for the graph
            graphView.addPlot(plot: linePlot!)
        }
        if dotPlot != nil { // Only runs if a dotPlot is set for the graph
            graphView.addPlot(plot: dotPlot!)
        }
        if referenceLines != nil { // Only runs if referenceLines are set for the graph
            graphView.addReferenceLines(referenceLines: referenceLines!)
        }
        self.view.addSubview(graphView) // Implement the graph
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
} // End of ViewController Class









//  func finalGraphInitialization(datesValueArray: [Double]) {
//      getBitcoinCurrentData{ (isCompleted, currentPrice) in
//         if isCompleted {
//            self.valuesArray = datesValueArray
//            self.valuesArray.append(currentPrice)
//            print(self.valuesArray)
//            self.quarter1 = self.valuesArray.max()! * 0.25
//            self.half = self.valuesArray.max()! * 0.5
//            self.quarter3 = self.valuesArray.max()! * 0.75
//            self.whole = self.valuesArray.max()!
//            self.makeGraphView(graph: self.graph)
//         } else {
//            print("Graph failed to load data")
//         }
//
//      }
//  }

