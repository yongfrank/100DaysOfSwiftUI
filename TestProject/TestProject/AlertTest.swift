//
//  AlertTest.swift
//  TestProject
//
//  Created by Frank Chu on 4/16/22.
//

import SwiftUI

struct AlertTest: View {
    
    @State var isShowingVar = false
    
    var body: some View {
        NavigationView {
            Text("HI")
                .navigationTitle("HI")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button() {
                            isShowingVar.toggle()
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
                .confirmationDialog("This will not show by default, if you want to show, change .automatic to .visible", isPresented: $isShowingVar, titleVisibility: .automatic) {
                    Button("Delete Photo", role: .destructive) {}
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("This photo will be deleted from iCloud Photos on all your devices.")
                }
        }
    }
}

struct AlertTest_Previews: PreviewProvider {
    static var previews: some View {
        AlertTest()
    }
}
