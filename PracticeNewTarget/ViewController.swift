/// <#Brief Description#>
///
/// Created by TWINB00776283 on 2025/3/25.
/// Copyright © 2025 Cathay United Bank. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    var value: Double = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let currency: CurrencyTool.Currency = .USD
        let swapToCurrency: CurrencyTool.Currency = .JPY
        
        let currencyTool = CurrencyTool()
        currencyTool.swapCurrency(value: value, currency: currency, swapTo: swapToCurrency) { result in
            
            switch result {
            case .success(let swapValue):
                print("\(self.value) \(swapToCurrency) to \(swapValue) \(currency)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

