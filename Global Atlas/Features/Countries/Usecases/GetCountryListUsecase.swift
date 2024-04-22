//
//  GetCountryListUsecase.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

protocol GetCountryListUsecase {
    func getCountriesList(fields: [String], _ completion: @escaping(Result<[Country], NetworkServiceError>) -> Void)
}
