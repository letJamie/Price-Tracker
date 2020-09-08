//
//  ViewController.swift
//  Price Tracker
//
//  Created by Jamie on 2020/09/06.
//  Copyright © 2020 Jamie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPrice()
    }
    
    func getPrice() {
        
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    
                    if data != nil {
                        
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Double] {
                            
                            DispatchQueue.main.async {
                                
                                if let usdPrice = json["USD"] {
                                    
                                    self.usdLabel.text = self.getStringFor(price: usdPrice, currencyCode: "USD")
                                }
                                
                                if let eurPrice = json["EUR"] {
                                    self.eurLabel.text = self.getStringFor(price: eurPrice, currencyCode: "EUR")
                                }
                            }
                        }
                    }
                    
                } else {
                    print("error")
                }
                
            }.resume()
        }
    }
    
    func getStringFor(price: Double, currencyCode: String) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        
        if let usdString = formatter.string(from: NSNumber(value: price)) {
                 
            return usdString
        }
        
        return "error"
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        
        getPrice()
    }
    
}

