////
////  Day69-2-using-touch-id-and-face-id-with-swiftui.swift
////  BucketList
////
////  Created by Frank Chu on 6/9/22.
////
//
//import SwiftUI
//import LocalAuthentication
//
//struct Day69_2_using_touch_id_and_face_id_with_swiftui: View {
//    
//    @State private var isUnlocked = false
//    
//    var body: some View {
//        
//        VStack {
//            if isUnlocked {
//                Text("Hello world")
//                Text("Unlocked, I'm Sherlocked")
//            } else {
//                Text("Locked")
//                Text("Please unlock your app")
//                Button("Unlocked your app") {
//                    authenticate()
//                }
//            }
//            
//        }
//        .onAppear(perform: authenticate)
//    }
//    
//    func authenticate() {
//        let context = LAContext()
//        var error: NSError?
//        
//        // Check whether biometric authentication is possible
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
//            let reason = "We need to unlock your data"
//            
//            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
//                if success {
//                    isUnlocked = true
//                } else {
//                    // there was a problem
//                }
//            }
//        } else {
//            // no biometrics
//        }
//    }
//}
//
//struct Day69_2_using_touch_id_and_face_id_with_swiftui_Previews: PreviewProvider {
//    static var previews: some View {
//        Day69_2_using_touch_id_and_face_id_with_swiftui()
//    }
//}
