//
//  DrawingManager.swift
//  DrawingDocApp
//
//  Created by Frank Chu on 4/14/22.
//

import Foundation
import SwiftUI

class DrawingManager: ObservableObject {
    @Published var docs: [DrawingDocument]
    
    init() {
        docs = CoreDataManager.coreDataManagerSharedClass.getData()
    }
    
    func addData(doc: DrawingDocument) {
        docs.append(doc)
        CoreDataManager.coreDataManagerSharedClass.addData(doc: doc)
    }
    
    func getData(for id: UUID) -> Data {
        if let doc = self.docs.first(where: { $0.id == id }) {
            return doc.data
        }
        return Data()
    }
    
    func update(data: Data, for id: UUID) {
        if let index = self.docs.firstIndex(where: { $0.id == id }) {
            self.docs[index].data = data
            CoreDataManager.coreDataManagerSharedClass.updateData(data: self.docs[index])
        }
    }
    
    func delete(for indexSet: IndexSet) {
        for index in indexSet {
            CoreDataManager.coreDataManagerSharedClass.deleteData(data: docs[index])
            docs.remove(at: index)
        }
    }
}
