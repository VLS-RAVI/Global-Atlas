//
//  TestUtils.swift
//  Global AtlasTests
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

enum MockJsonFileTypes {
    case countries
    case countryDetails

    var fileName: String {
        switch self {
        case .countries:
            return "Countries"
        case .countryDetails:
            return "CountryDetails"
        }
    }
}

class TestUtils {
    private init() {}
    static func loadJson<T: Codable>(fileName: String) -> T? {
        if let url = Bundle(for: TestUtils.self).url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print(error)
            }
        }
        return nil
    }
}

enum TestStatus {
    case success
    case error
}
