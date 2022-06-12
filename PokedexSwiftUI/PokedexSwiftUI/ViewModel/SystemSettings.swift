//
//  SystemSettings.swift
//  PokedexSwiftUI
//
//  Created by Frank Chu on 6/11/22.
//

import Foundation

class SystemSettings: ObservableObject {
    @Published var showFilterButton = false
    @Published var filteredApplied = false
}
