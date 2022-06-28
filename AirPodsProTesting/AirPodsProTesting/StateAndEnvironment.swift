//
//  StateAndEnvironment.swift
//  AirPodsProTesting
//
//  Created by Frank Chu on 6/27/22.
//

import SwiftUI

class dataTest: ObservableObject {
    @Published var name = "Frank"
    var sex = "Make"
}

struct StateAndEnvironment: View {
    @StateObject var vm = dataTest()
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("Name", text: $vm.name)

                NavigationLink {
                    SecondView()
                } label: {
                    Text("Second View")
                }
            }
        }
        .environmentObject(vm)
    }
}

struct SecondView: View {
    @EnvironmentObject var vm2: dataTest
    var body: some View {
        VStack {
            Text("HI")
            Text(vm2.name)
            NavigationLink {
                ThirdView()
            } label: {
                Text("Third View")
            }
        }
        
    }
}
struct ThirdView: View {
    @ObservedObject var vm3 = dataTest()
    var body: some View {
        VStack {
            Text("Third")
            TextField("", text: $vm3.name)
//            NavigationLink {
//                SecondView()
//            } label: {
//                Text("Third View")
//            }
        }
        
    }
}

struct StateAndEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        StateAndEnvironment()
    }
}
