//
//  CountryDetailsViewModel.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

class CountryDetailsViewModel: ObservableObject {
    //MARK: Reactive Properties
    @Published var state: ViewState = .updated
    @Published var showError: Bool = false
    
    //MARK: Properties
    private let usecase: GetCountryDetailsUsecase
    let countryName: String
    private let countryCode: String
    private (set) var country: Country?
    private (set) var errorMessage: String = ""

    init(usecase: GetCountryDetailsUsecase, countryName: String, countryCode: String) {
        self.usecase = usecase
        self.countryName = countryName
        self.countryCode = countryCode
    }
    
    func fetchCountryDetails() {
        state = .loading
        let fields = CountryField.allCases.map{$0.rawValue}
        usecase.getCountryDetails(countryCode: countryCode, fields: fields) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let respose):
                if let country = respose.first {
                    self.country = country
                    self.state = .updated
                } else {
                    self.state = .error("No data found")
                    errorMessage = "No data found"
                    showError = true
                }
                
            case .failure(let error):
                debugPrint(error)
                self.state = .error(error.localizedDescription)
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}
