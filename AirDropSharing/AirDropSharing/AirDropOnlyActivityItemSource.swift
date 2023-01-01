//
//  AirDropOnlyActivityItemSource.swift
//  AirDropSharing
//
//  Created by Frank Chu on 12/29/22.
//

import Foundation
import UIKit
import LinkPresentation

final class AirDropOnlyActivityItemSource: NSObject {
    let item: Any
    
    init(item: Any) {
        self.item = item
    }
    
    convenience init(pokeCard: PokeCard) {
        let data = Encoder.jsonData(from: pokeCard)
        self.init(item: data)
    }
}

extension AirDropOnlyActivityItemSource: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return NSURL(string: "")!
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return item
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?) -> String {
        return "com.yongfrank.AirDropSharingUTI.share"
    }
    
    
    /// MetaData for Sharing
    /// - Parameter activityViewController: <#activityViewController description#>
    /// - Returns: <#description#>
    /// - Note: https://developer.apple.com/documentation/linkpresentation/lplinkmetadata
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        
        let linkMetadata = LPLinkMetadata()
        linkMetadata.title = "Share pokemon card"
        
        let fileUrl = AssetExtractor.createLocalUrl(forImageNamed: "pokemon_tcg")
        linkMetadata.iconProvider = NSItemProvider(contentsOf: fileUrl)
        return linkMetadata
    }
    
    
}

enum Encoder {
    
    static func jsonData<T: Encodable>(from encodableData: T) -> Data {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(encodableData)
            
            #if DEBUG
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
            #endif
            
            return data;
        } catch {
            fatalError("Encoding failure. error: \(error)")
        }
    }
}
