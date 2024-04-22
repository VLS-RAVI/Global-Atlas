//
//  MockCountryDetailsService.swift
//  Global AtlasTests
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation
@testable import Global_Atlas

class MockCountryDetailsService: GetCountryDetailsUsecase {
    var status: TestStatus = .success

    func getCountryDetails(countryCode: String, fields: [String], _ completion: @escaping (Result<[Global_Atlas.Country], Global_Atlas.NetworkServiceError>) -> Void) {
        switch status {
        case .success:
            if let mockResponse = generateMockResponse() {
                completion(.success(mockResponse))
            } else {
                completion(.failure(.notFound))
            }
        case .error:
            completion(.failure(.invalidResponse))
        }
    }
    
    private func generateMockResponse() -> [Country]? {
        return TestUtils.loadJson(fileName: MockJsonFileTypes.countryDetails.fileName)
    }
}
