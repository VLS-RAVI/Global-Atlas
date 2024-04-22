//
//  CountryListViewModel.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import Foundation

class CountryListViewModel: ObservableObject {
    
    //MARK: Reactive Properties
    @Published var state: ViewState = .updated 
    @Published var showError: Bool = false
    
    private (set) var searchedCountries: [Country] = []
    private (set) var errorMessage: String = ""

    //MARK: Properties
    private let usecase: GetCountryListUsecase
    private var countries: [Country] = []
    
    var searchText: String = "" {
        didSet {
            if searchText.isEmpty {
                searchedCountries = countries
            } else {
                self.searchedCountries = self.countries.filter {
                    $0.name?.lowercased().contains(self.searchText.lowercased()) ?? false
                }
            }
            self.state = .updated
        }
    }
    
    init(usecase: GetCountryListUsecase) {
        self.usecase = usecase
    }
    
    func fetchCountries() {
        state = .loading
        let fields = [CountryField.name.rawValue, CountryField.capital.rawValue, CountryField.alpha3Code.rawValue]
        usecase.getCountriesList(fields: fields) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let respose):
                self.countries = respose
                self.searchedCountries = self.countries
                self.state = .updated
            case .failure(let error):
                debugPrint(error)
                self.state = .error(error.localizedDescription)
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }
}
