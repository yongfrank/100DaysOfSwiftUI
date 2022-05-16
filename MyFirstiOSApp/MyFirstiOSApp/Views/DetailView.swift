//
//  DetailView.swift
//  MyFirstiOSApp
//
//  Created by Frank Chu on 4/19/22.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16.0) {
                Image("Vector")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 128)
                    .frame(maxWidth: .infinity)
                Text("SwiftUI for iOS 14")
                    .font(.title)
                    .fontWeight(.bold)
                Text("A complete guide to designing for iOS 14 with videos, examples and design files")
                    .opacity(0.7)
                    .lineLimit(2)
                Text("20 sections - 3 hours")
                    .opacity(0.7)
                
            }
            .foregroundColor(.white)
            .padding(16)
    //        .frame(width: 252, height: 329)
            .background(LinearGradient(
                gradient: Gradient(stops: [
            .init(color: Color(#colorLiteral(red: 0.4000000059604645, green: 0.4941176474094391, blue: 0.9176470637321472, alpha: 1)), location: 0),
            .init(color: Color(#colorLiteral(red: 0.4627451002597809, green: 0.29411765933036804, blue: 0.6352941393852234, alpha: 1)), location: 1)]),
                startPoint: UnitPoint(x: 0, y: 0.5),
            endPoint: UnitPoint(x: 1, y: 0.5)))
            
            VStack(alignment: .leading, spacing: 16) {
                Text("How to use SwiftUI")
                    .fontWeight(.bold)
                Text("This is course")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            }
            .padding()
        }
//        .ignoresSafeArea()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
