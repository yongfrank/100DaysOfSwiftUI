//
//  ChatUser.swift
//  LBTASwiftUIFirebaseChat
//
//  Created by Frank Chu on 8/24/22.
//

import Foundation

enum DataDic {
    static var uid = "uid", email = "email", profileImageUrl = "profileImageUrl"
}

struct ChatUser: Identifiable, Hashable {
    
    var id: String { uid }
    
    let uid, email, profileImageUrl: String
    init(data: [String: Any]) {
        self.uid = data[DataDic.uid] as? String ?? ""
        self.email = data[DataDic.email] as? String ?? ""
        self.profileImageUrl = data[DataDic.profileImageUrl] as? String ?? ""
    }
    
    static let example = ChatUser(data: ["uid": "fZqhhKKN7dVguiYQC1NuuF69WRZ2", "email": "Pikachu@EXAMPLE.com", "profileImageUrl": "https://firebasestorage.googleapis.com:443/v0/b/lbta-swiftui-firebase-ch-e575b.appspot.com/o/FgZ1nd2rSFNi5ys2U9U9VJyxUTW2?alt=media&token=88470946-cbfc-4188-90cc-b5ba9642a1f5"])
}
