///
/// Created by TWINB00776283 on 2025/3/25.
/// Copyright © 2025 Cathay United Bank. All rights reserved.

open class CurrencyTool {
    
    let fetchAPI = CurrencyFetchAPI()
    
    public enum Currency: String {
        case USD
        case EUR
        case JPY
        case TWD
    }
    
    public enum CurrencyError: Error {
        case valueLessThanZero
    }
    
    open func swapCurrency(value: Double, currency origianlCurrency: Currency, swapTo objectCurrency: Currency, completion: @escaping(_ result: Result<Double, Error>) -> Void) {
        
        if value >= 0 {
            
            fetchAPI.performRequest { result in
                
                switch result {
                case .success(let currencyData):
                    
                    let originalRate: Double
                    let targetRate: Double
                    
                    switch origianlCurrency {
                    case .USD: originalRate = currencyData.usd.value
                    case .EUR: originalRate = currencyData.eur.value
                    case .JPY: originalRate = currencyData.jpy.value
                    case .TWD: originalRate = currencyData.twd.value
                    }
                    
                    switch objectCurrency {
                    case .USD: targetRate = currencyData.usd.value
                    case .EUR: targetRate = currencyData.eur.value
                    case .JPY: targetRate = currencyData.jpy.value
                    case .TWD: targetRate = currencyData.twd.value
                    }
                    
                    var conversionRate: Double = 0
                    
                    conversionRate = originalRate / targetRate
                    
                    let convertedValue = value * conversionRate
                    
                    completion(.success(convertedValue))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            return
        }
    }
    
    public init() {
        
    }
}
