//
//  GetCountryDetailsUsecase.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

protocol GetCountryDetailsUsecase {
    func getCountryDetails(countryCode: String, fields: [String], _ completion: @escaping(Result<[Country], NetworkServiceError>) -> Void)
}
