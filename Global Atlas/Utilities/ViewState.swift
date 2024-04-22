//
//  ViewState.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case error(_ message: String)
    case updated
}
