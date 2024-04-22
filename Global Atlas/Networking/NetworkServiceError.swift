//
//  NetworkServiceError.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

public enum NetworkServiceError: Error, Equatable {
    case noInternet
    case invalidRequest
    case invalidResponse
    case errorResponse(error: Error)
    case serverError(_ error: APIErrorResponse)
    case tryAgain
    case notFound

}

public func == (lhs: NetworkServiceError, rhs: NetworkServiceError) -> Bool {
    return lhs.errorDescription == rhs.errorDescription
}

extension NetworkServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "Please check your internet connection and try again."
        case .invalidRequest:
            return "Invalid request!"
        case .invalidResponse:
            return "The expected response data is incorrect."
        case .errorResponse(let error):
            return error.localizedDescription
        case .serverError(let error):
            return error.message
        case .tryAgain:
            return "Error, Please try again!"
        case .notFound:
            return "File not found"
        }
    }
}

public struct APIErrorResponse: Codable {
    let code: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}

public struct ErrorResponse: Codable {
    let error: APIErrorResponse

    enum CodingKeys: String, CodingKey {
        case error
    }
}
