//
//  DashboardView.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/23/22.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var env: GlobalEnvironment
    var body: some View {
        VStack {
            HStack {
                Text("Dashboard")
                    .font(.largeTitle)
                Spacer()
            }
            VStack {
                HStack {
                    Text(secondsToFullString(env.clocks.sumAllClocks())).font(.title) + Text(" Logged Today").font(.callout)
                    Spacer()
                }
            }
            .padding()
            .background(dGray.opacity(0.5))
            .cornerRadius(10)
            Spacer()
        }
//        .padding()
//        .background(dddGray)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(showSheet: .constant(false))
            .environmentObject(GlobalEnvironment())
    }
}
