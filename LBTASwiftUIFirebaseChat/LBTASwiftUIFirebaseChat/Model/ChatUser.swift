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
    
    static let example = ChatUser(data: ["uid": "fZqhhKKN7dVguiYQC1NuuF69WRZ2", "email": "EXAMPLE@EXAMPLE.com", "profileImageUrl": "https://via.placeholder.com/150"])
}
