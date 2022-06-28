//
//  RemindView.swift
//  Increment
//
//  Created by Frank Chu on 6/28/22.
//

import SwiftUI

struct RemindView: View {
    var body: some View {
        VStack {
            
            Spacer()
//            DropdownView()
            Spacer()
            Button {
                
            } label: {
                Text("Create")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 15)
            
            Button {
                
            } label: {
                Text("Skip")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Remind")
        .padding(.bottom, 15)
    }
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RemindView()
        }
    }
}
