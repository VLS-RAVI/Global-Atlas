//
//  CountryDetailItemView.swift
//  Global Atlas
//
//  Created by V L S RAVI on 21/04/24.
//

import SwiftUI

struct CountryDetailItemView: View {
    let title: String
    let value: String
    let alignment: HorizontalAlignment
    
    var body: some View {
        VStack(alignment: alignment, spacing: 6) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(Color.appAccent)

            Text(value)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(Color.appAccent)
        }
    }
}

#Preview {
    CountryDetailItemView(title: "Capital", value: "New Delhi", alignment: .leading)
}
