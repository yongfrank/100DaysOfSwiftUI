//
//  BadgeView.swift
//  Moonshot
//
//  Created by Frank Chu on 3/17/22.
//

import SwiftUI

struct BadgeView: View {
    var mission: Mission
    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(.lightBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
}

struct BadgeView_Previews: PreviewProvider {
    
    static var previews: some View {
        BadgeView(mission: missions[0])
            .padding()
    }
}
