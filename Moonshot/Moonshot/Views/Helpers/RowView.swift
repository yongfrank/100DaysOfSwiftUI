//
//  RowView.swift
//  Moonshot
//
//  Created by Frank Chu on 3/18/22.
//

import SwiftUI

struct RowView: View {
    let mission: Mission
    var body: some View {
        
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding()
            
            HStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(mission: missions[0])
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
