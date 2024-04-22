//
//  CountryDetailsView.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import SwiftUI
import Kingfisher

struct CountryDetailsView: View {
    @ObservedObject private var viewModel: CountryDetailsViewModel
    
    init(viewModel: CountryDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground
                .ignoresSafeArea()
            Group {
                switch viewModel.state {
                case .loading:
                    loadingView
                case .error( _):
                    EmptyView()
                case .updated:
                    contentView
                }
            }
        }
        .task {
            viewModel.fetchCountryDetails()
        }
    }
    
    @ViewBuilder
    private var loadingView: some View {
        VStack(alignment: .center, spacing: 40) {
            Image("flag_placeholder")
                .resizable()
                .frame(width: 320, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            List {
                ForEach(0..<8) { _ in
                    HStack(alignment: .center, spacing: 20) {
                        CountryDetailItemView(title: "Name", value: "placeholder", alignment: .leading)
                        Spacer()
                        CountryDetailItemView(title: "Capital", value: "placeholder", alignment: .trailing)
                    }
                }
            }
        }
        .redacted(reason: .placeholder)
    }
    
    @ViewBuilder
    private var contentView: some View {
        if let country = viewModel.country {
            GeometryReader { geometry in
                if geometry.size.height > geometry.size.width {
                    //portrait
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .center, spacing: 40) {
                            FlagView(country: country)
                            DetailsContainerView(country: country)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                    }
                } else {
                    //landscape
                    HStack(alignment: .center, spacing: 40) {
                        FlagView(country: country)
                        Spacer()
                        ScrollView(showsIndicators: false) {
                            DetailsContainerView(country: country)
                            
                        }
                        //                    .padding(.horizontal, 20)
                    }
                }
            }
            
        }
    }
    
    #Preview {
        CountryDetailsView(viewModel: CountryDetailsViewModel(usecase: CountryDetailsService(), countryName: "India", countryCode: "Ind"))
    }
    
    struct FlagView : View {
        let country: Country
        var body: some View {
            KFImage(URL(string: country.flag?.png ?? ""))
                .placeholder {
                    Image(systemName: "flag.square.fill")
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20).stroke(Color.appAccent, lineWidth: 4)
                }
        }
    }
    
    struct DetailsContainerView: View {
        let country: Country
        var body: some View {
            
            VStack(spacing: 40) {
                HStack(alignment: .center, spacing: 20) {
                    CountryDetailItemView(title: "Name", value: country.name ?? "", alignment: .leading)
                    Spacer()
                    CountryDetailItemView(title: "Capital", value: country.capital ?? "", alignment: .trailing)
                }
                
                HStack {
                    CountryDetailItemView(title: "Region", value: country.region ?? "", alignment: .leading)
                    Spacer()
                    CountryDetailItemView(title: "Subregion", value: country.subregion ?? "", alignment: .trailing)
                }
                
                HStack {
                    CountryDetailItemView(title: "Population", value: String(country.population ?? 0), alignment: .leading)
                    Spacer()
                    CountryDetailItemView(title: "Lat-Long", value: country.latlng?.compactMap {String($0)}.joined(separator: ",") ?? "", alignment: .trailing)
                }
                
                HStack {
                    CountryDetailItemView(title: "Language", value: country.languages?.first?.name ?? "", alignment: .leading)
                    Spacer()
                    CountryDetailItemView(title: "Currency", value: "(\(country.currencies?.first?.code ?? ""))" + " " + (country.currencies?.first?.name ?? ""), alignment: .trailing)
                }
            }
        }
    }
}
