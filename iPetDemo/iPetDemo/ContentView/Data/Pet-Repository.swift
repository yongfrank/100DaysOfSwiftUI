//
//  Pet-Repository.swift
//  iPetDemo
//
//  Created by Frank Chu on 6/12/22.
//

import Foundation

class PetRepository {
    private let PET_KEY = "PET_KEY"
    private var pet: Pet
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: PET_KEY) {
            if let decoded = try? JSONDecoder().decode(Pet.self, from: data) {
                self.pet = decoded
                print("Data Retrived in UserDefaults")
                return
            }
        }
        
        self.pet = Pet(name: "Frank", lastMeal: Date(), lastDrink: Date())
    }
    
    func load() -> Pet {
        return self.pet
    }
    
    func save(pet: Pet) {
        if let encoded = try? JSONEncoder().encode(pet) {
            UserDefaults.standard.set(encoded, forKey: PET_KEY)
            print("Data saved at: \(Date().formatted(date: .omitted, time: .standard))")
        }
    }
}
