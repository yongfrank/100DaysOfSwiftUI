//
//  ItemView.swift
//  AnimeQuotes
//
//  Created by Frank Chu on 6/12/22.
//

import SwiftUI

struct ItemView: View {
    let quote: Quote
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(quote.anime)
                .font(.headline)
            
            Divider()
            
            Text(quote.quote)
                .font(.body)
            
            HStack {
                Spacer()
                Text("- \(quote.character)")
                    .font(.footnote)
            }
        }
//        .padding()
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(quote: Quote.SampleQuote)
    }
}
