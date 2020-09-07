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
                                    self.usdLabel.text = "$\(usdPrice)"
                                }
                                
                                if let eurPrice = json["EUR"] {
                                    self.eurLabel.text = "Euro \(eurPrice)"
                                }
                                
                                if let jpyPrice = json["JPY"] {
                                    print(jpyPrice)
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
    
    @IBAction func refreshTapped(_ sender: Any) {
        
        getPrice()
    }
    
}

