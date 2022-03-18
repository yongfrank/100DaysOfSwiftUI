//
//  ListLayout.swift
//  Moonshot
//
//  Created by Frank Chu on 3/18/22.
//

import SwiftUI

struct ListLayout: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission)
                    } label: {
                        RowView(mission: mission)
                    }
                }
                
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout_Previews: PreviewProvider {
    static var previews: some View {
        ListLayout()
    }
}
