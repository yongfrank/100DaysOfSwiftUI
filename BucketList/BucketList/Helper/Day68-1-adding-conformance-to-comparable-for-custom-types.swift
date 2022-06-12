////
////  Day68-1-adding-conformance-to-comparable-for-custom-types.swift
////  BucketList
////
////  Created by Frank Chu on 6/8/22.
////
//
//import SwiftUI
//
//struct User: Identifiable, Comparable {
//    static func < (lhs: User, rhs: User) -> Bool {
//        lhs.firstName < rhs.firstName
//    }
//    
//    let id = UUID()
//    let firstName: String
//    let lastName: String
//}
//
//struct Day68_1_adding_conformance_to_comparable_for_custom_types: View {
//    let nums = [3, 4, 1, 2].sorted()
//    
//    let users = [
//        User(firstName: "9", lastName: "A"),
//        User(firstName: "8", lastName: "B"),
//        User(firstName: "7", lastName: "DD")
//    ].sorted()
//    
//    var body: some View {
//        
//        VStack {
//            List(users) { user in
//                Text("\(user.firstName) \(user.lastName)")
//            }
//            List {
//                ForEach(nums, id: \.self) { num in
//                    Text("\(num)")
//                }
//            }
//
//            List(nums, id: \.self) {
//                Text(String($0))
//            }
//        }
//    }
//}
//
//struct Day68_1_adding_conformance_to_comparable_for_custom_types_Previews: PreviewProvider {
//    static var previews: some View {
//        Day68_1_adding_conformance_to_comparable_for_custom_types()
//    }
//}
