/// <#Brief Description#> 
///
/// Created by TWINB00776283 on 2025/3/26.
/// Copyright © 2025 Cathay United Bank. All rights reserved.

public struct APIData: Decodable {
    let meta: LastUpdate
    let data: CurrencyData
}

public struct LastUpdate: Decodable {
    let lastUpdatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedAt = "last_updated_at"
    }
}

public struct CurrencyData: Decodable {
    let eur: Currency
    let jpy: Currency
    let usd: Currency
    let twd: Currency
    
    enum CodingKeys: String, CodingKey {
        case eur = "EUR"
        case jpy = "JPY"
        case usd = "USD"
        case twd = "TWD"
    }
}

public struct Currency: Decodable {
    let code: String
    let value: Double
}

