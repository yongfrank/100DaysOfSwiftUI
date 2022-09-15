//
//  MilkShake.swift
//  FoodDeliveryApp
//
//  Created by Frank Chu on 9/12/22.
//

import Foundation

struct MilkShake: Equatable {
    var id: String = UUID().uuidString
    var title: String
    var price: String
    var image: String
}

var milkShakes: [MilkShake] = [
    .init(title: "Milk Frappe", price: "$26.99", image: "Shake 1"),
    .init(title: "Milk & Chocalate\nFrappe", price: "$29.99", image: "Shake 2"),
    .init(title: "Frappuccino", price: "$49.99", image: "Shake 3"),
    .init(title: "Espresso", price: "$19.99", image: "Shake 4"),
    .init(title: "Crème Frappuccino", price: "$39.99", image: "Shake 5")
]
