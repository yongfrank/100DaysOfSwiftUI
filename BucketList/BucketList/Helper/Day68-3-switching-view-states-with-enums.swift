////
////  Day68-3-switching-view-states-with-enums.swift
////  BucketList
////
////  Created by Frank Chu on 6/9/22.
////
//
//import SwiftUI
//
//enum LoadingState {
//    case loading, success, failed
//}
//
//struct LoadingView: View {
//    var body: some View {
//        Text("Loading...")
//    }
//}
//
//struct FailedView: View {
//    var body: some View {
//        Text("Failed.")
//    }
//}
//
//struct SuccessView: View {
//    var body: some View {
//        Text("Success!")
//    }
//}
//
//struct Day68_3_switching_view_states_with_enums: View {
//    
//    var loadingState = LoadingState.loading
//    
//    var body: some View {
//        
//        if loadingState == .loading {
//            LoadingView()
//        } else if loadingState == .success {
//            SuccessView()
//        } else if loadingState == .failed {
//            FailedView()
//        }
////        if Bool.random() {
////            Rectangle()
////        } else {
////            Circle()
////        }
//    }
//}
//
//struct Day68_3_switching_view_states_with_enums_Previews: PreviewProvider {
//    static var previews: some View {
//        Day68_3_switching_view_states_with_enums()
//    }
//}
