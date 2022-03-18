//
//  CrewCard.swift
//  Moonshot
//
//  Created by Frank Chu on 3/18/22.
//

import SwiftUI

struct CrewCard: View {
    
    let crew: [CrewMember]
    let mission: Mission
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                        
                        }
                        .padding(.horizontal)
                    
                    }
                }
            }
        }
    
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

}

struct CrewCard_Previews: PreviewProvider {
    static var previews: some View {
        CrewCard(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
