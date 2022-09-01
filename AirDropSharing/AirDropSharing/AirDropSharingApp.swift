//
//  AirDropSharingApp.swift
//  AirDropSharing
//
//  Created by Frank Chu on 8/26/22.
//

import SwiftUI

class ReceievedData: ObservableObject {
    @Published var user: FitnessData? = nil
    
    
    init() {
        
    }
}

@main
struct AirDropSharingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
    @StateObject var receivedData = ReceievedData()
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            open(urlContexts: URLContexts)
        }

        private func open(urlContexts: Set<UIOpenURLContext>) {
            guard let urlContext = urlContexts.first else {
                return
            }
            do {
                let receivedData = try Data(contentsOf: urlContext.url)
                guard let receivedData: FitnessData = try? JSONDecoder().decode(FitnessData.self, from: receivedData) else {
                    print("DEBUG: receivedPokeCard Failed")
                    return
                }
                self.receivedData.user = receivedData
            } catch {
                print("data is nil. fromUrl: \(urlContext.url.path)")
                return
            }
        }
    
    var window: UIWindow?

        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            // アプリ未起動時にAirDrop受け取りから起動した場合
            if let urlContext = connectionOptions.urlContexts.first {
                do {
                    let receivedData = try Data(contentsOf: urlContext.url)
                    // PokeCardにデコード
                    guard let receivedData: FitnessData = try? JSONDecoder().decode(FitnessData.self, from: receivedData) else {
                        print("DEBUG: guard let receivedPokeCard")
                        return
                    }
                    // シングルトンに値を保持しておいて、最初のViewControllerのviewDidAppearで使用する
                    
                    self.receivedData.user = receivedData
//                    let receivedPokeCardRepository = ReceivedPokeCardRepositoryProvider.provide()
//                    receivedPokeCardRepository.write(receivedPokeCard: receivedPokeCard)
                } catch {
                    print("data is nil. fromUrl: \(urlContext.url.path)")
                    return
                }
            }
            
        }
}

import UIKit
import LinkPresentation

//final class AirDropOnlyActivityItemSource: NSObject {
//    /// AirDropで送信するアイテム
//    let item: Any
//
//    init(item: Any) {
//        self.item = item
//    }
//
//    /// 送信するポケモンカードを指定してイニシャライズ
//    convenience init(pokeCard: FitnessData) {
//        guard let data = try? JSONEncoder().encode(pokeCard) else {
//            print("DEBUG: convenience init failed")
//            return
//        }
//        self.init(item: data)
//    }
//}

//extension AirDropOnlyActivityItemSource: UIActivityItemSource {
//    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
//        //using NSURL here, since URL with an empty string would crash
//        return NSURL(string: "")!
//    }
//
//    func activityViewController(
//        _ activityViewController: UIActivityViewController,
//        itemForActivityType activityType: UIActivity.ActivityType?
//    ) -> Any? {
//        return item
//    }
//
//    func activityViewController(
//        _ activityViewController: UIActivityViewController,
//        dataTypeIdentifierForActivityType activityType: UIActivity.ActivityType?
//    ) -> String {
//        // Info.plistで定義したUTIのIdentifierを指定
//        return "com.yongfrank.AirDropSharingUTI.share"
//    }
//
//    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
//        let linkMetadata = LPLinkMetadata()
//        linkMetadata.title = "Share pokemon card"
//
//        let fileUrl = AssetExtractor.createLocalUrl(forImageNamed: "pokemon_tcg")
//        linkMetadata.iconProvider = NSItemProvider(contentsOf: fileUrl)
//
//        return linkMetadata
//    }
//}

enum Encoder {

    /// Json encoding
    static func jsonData<T: Encodable>(from encodableData: T) -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(encodableData)
#if DEBUG
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            }
#endif
            return data
        } catch {
            // サンプルではfatalErrorで落としてしまっていますが、throwしてあげた方が優しいかもです
            fatalError("Encoding failure. error: \(error)")
        }
    }
}
