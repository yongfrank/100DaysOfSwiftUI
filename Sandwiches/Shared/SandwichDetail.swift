//
//  SandwichDetail.swift
//  Sandwiches
//
//  Created by Frank Chu on 4/9/22.
//

import SwiftUI

struct SandwichDetail: View {
    var sandwich: Sandwich
    @State var zoomed = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            Image("catAvater")
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill : .fit)
                .onTapGesture {
                    withAnimation {
                        zoomed.toggle()
                    }
                }
                
            Spacer(minLength: 0)
            if !zoomed {
                HStack {
                    Spacer()
                    Label("Spicy", systemImage: "flame.fill")
                    Spacer()
                }
                .padding(.all)
                .font(Font.headline.smallCaps())
                .background(.red)
                .foregroundColor(.yellow)
                .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle(sandwich.name)
//        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SandwichDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SandwichDetail(sandwich: testData[0])
        }
    }
}
