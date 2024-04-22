//
//  CountryListView.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject private var viewModel: CountryListViewModel
    private var errorMessage: String = ""
    
    init(viewModel: CountryListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Color.appBackground
                    .ignoresSafeArea()
                switch viewModel.state {
                case .loading:
                    loadingView
                case .error( _):
                    EmptyView()
                case .updated:
                    searchResultsView
                }
            }
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                        title: Text("Error"),
                        message: Text(viewModel.errorMessage)
                    )
        }
        .task {
            viewModel.fetchCountries()
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        List {
            ForEach(0..<15) { _ in
                HStack{
                    Text("placeholder - text")
                        .redacted(reason: .placeholder)
                }
            }
        }
    }
    
    @ViewBuilder
    private var searchResultsView: some View {
        List {
            ForEach(viewModel.searchedCountries, id: \.self) { country in
                
                NavigationLink(value: country) {
                    VStack(alignment: .leading) {
                        Text(country.name ?? "")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.appAccent)
                        Text(country.capital ?? "")
                            .font(.caption)
                            .foregroundStyle(Color.appAccent)
                    }
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.large)
        .scrollDismissesKeyboard(.interactively)
        .navigationDestination(for: Country.self) { country in
            CountryDetailsView(viewModel: CountryDetailsViewModel(usecase: CountryDetailsService(), countryName: country.name ?? "", countryCode: country.alpha3Code ?? ""))
        }
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic))
        .navigationTitle("Countries")
        .navigationBarBackButtonHidden(true)
    }
}



#Preview {
    CountryListView(viewModel: CountryListViewModel(usecase: CountryListService()))
}
