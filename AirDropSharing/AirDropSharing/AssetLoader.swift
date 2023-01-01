//
//  AssetLoader.swift
//  AirDropSharing
//
//  Created by Frank Chu on 12/29/22.
//

import Foundation
import UIKit

final class AssetLoader {
    static func loadWithDecode<T: Decodable>(name: String, decoder: () -> JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }) -> T {
        guard let dataAssset = NSDataAsset(name: name, bundle: .init(for: self)) else {
            fatalError("Asset data loading failure.")
        }
        
        do {
            return try decoder().decode(T.self, from: dataAssset.data)
        } catch {
            fatalError("Decoding failure. error: \(error)")
        }
    }
}


final class AssetExtractor {
    static func createLocalUrl(forImageNamed name: String) -> URL? {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            guard let data = UIImage(named: name)?.pngData() else {
                return nil
            }
            
            FileManager.default.createFile(atPath: url.path, contents: data)
            
            return url
        }
        return url
    }
}


