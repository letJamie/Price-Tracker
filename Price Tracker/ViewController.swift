//
//  ViewController.swift
//  Price Tracker
//
//  Created by Jamie on 2020/09/06.
//  Copyright © 2020 Jamie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    
                    if data != nil {
                        
                        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Double] {
                            
                            if let usdPrice = json["USD"] {
                                print(usdPrice)
                            }
                            
                            if let eurPrice = json["EUR"] {
                                print(eurPrice)
                            }
                            
                            if let jpyPrice = json["JPY"] {
                                print(jpyPrice)
                            }
                            
                            
                        }
                    }
                    
                   
                } else {
                    print("error")
                }
                
            }.resume()
            
        }
        
        
        // Do any additional setup after loading the view.
    }


}

