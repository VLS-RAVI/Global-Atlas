//
//  Global_AtlasApp.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import SwiftUI

@main
struct Global_AtlasApp: App {
    var body: some Scene {
        WindowGroup {
            CountryListView(viewModel: CountryListViewModel(usecase: CountryListService()))
        }
    }
}
