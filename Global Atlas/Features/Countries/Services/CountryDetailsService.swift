//
//  CountryDetailsService.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

class CountryDetailsService {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension CountryDetailsService: GetCountryDetailsUsecase {
    func getCountryDetails(countryCode: String, fields: [String] = [], _ completion: @escaping (Result<[Country], NetworkServiceError>) -> Void) {
        let endpoint = "/v2/alpha?codes=\(countryCode)&fields=" + fields.joined(separator: ",")
        
        networkManager.callAPI(.get,
                                   endPoint: endpoint,
                                   completionHandler: completion)
    }
    
}
