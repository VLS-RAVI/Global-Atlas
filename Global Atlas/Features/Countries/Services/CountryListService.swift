//
//  CountryListService.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

class CountryListService {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension CountryListService: GetCountryListUsecase {
    func getCountriesList(fields: [String] = [], _ completion: @escaping (Result<[Country], NetworkServiceError>) -> Void) {
        let endpoint = "/v2/all?fields=" + fields.joined(separator: ",")
        
        networkManager.callAPI(.get,
                                   endPoint: endpoint,
                                   completionHandler: completion)
    }
    
}
