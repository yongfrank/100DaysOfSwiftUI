//
//  ContentView.swift
//  iPetDemo
//
//  Created by Frank Chu on 6/12/22.
//

import SwiftUI




struct ContentView: View {
    @StateObject var vm = ViewModel()
    var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        Form {
            Section("Pet") {
                TextField("Name your pet!", text: $vm.pet.name)
                
                Image(vm.pet.isHappy ? "happy_pet" : "sad_pet")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .centerHStack()
                
                Text("Birthday: **\(vm.pet.birthday)**")
                Text("Age: **\(vm.pet.age)** seconds")
                Text("Status: **\(vm.pet.isHappy ? "Happy" : "UnHappy")**")
                Text("Hunger: **\(vm.pet.hunger)**")
                Text("Thirst: **\(vm.pet.thirsty)**")
            }
            
            Section("actions") {
                Button("Feed", action: vm.feed)
                Button("Give water", action: vm.giveWater)
            }
        }
        .onReceive(timer) { _ in
            vm.saveData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
