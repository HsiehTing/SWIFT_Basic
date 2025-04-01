/// <#Brief Description#>
///
/// Created by TWINB00776283 on 2025/3/26.
/// Copyright © 2025 Cathay United Bank. All rights reserved.
import Foundation

public class CurrencyFetchAPI {
    
    fileprivate let urlString: String = "https://api.currencyapi.com/v3/latest?apikey=cur_live_vz8UMwhpSSi1xNYMaxkNT8vfBMDtdDVVwbztEYpg&currencies=EUR%2CUSD%2CTWD%2CJPY"
    
    public func performRequest(completion: @escaping (_ result: Result <CurrencyData, Error>) -> Void ) {
        guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error { print(error) }

                let decoder = JSONDecoder()
                
                guard let data = data else { return }
                
                do {
                    let decodedData = try decoder.decode(APIData.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData.data))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    print(error)
                }
            }.resume()
    }
}
