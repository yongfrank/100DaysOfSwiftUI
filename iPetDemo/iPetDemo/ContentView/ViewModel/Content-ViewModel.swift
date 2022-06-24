//
//  Content_ViewModel.swift
//  iPetDemo
//
//  Created by Frank Chu on 6/12/22.
//

import Foundation

extension ContentView {
    
}

class ViewModel: ObservableObject {
    @Published var pet: Pet
    private var repository = PetRepository()
    
    init() {
        pet = repository.load()
    }
    
    func feed() {
        pet.lastMeal = Date()
        saveData()
    }
    
    func giveWater() {
        pet.lastDrink = Date()
        saveData()
    }
    
    func saveData() {
        objectWillChange.send()
        repository.save(pet: pet)
    }
}
