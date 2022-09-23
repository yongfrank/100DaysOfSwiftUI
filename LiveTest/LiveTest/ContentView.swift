//
//  ContentView.swift
//  LiveTest
//
//  Created by Frank Chu on 9/15/22.
//  https://www.youtube.com/watch?v=mBAgCZJr6jw
//  iOS 16 Beta 4 Lock Screen Live Activities API - Xcode 14 - SwiftUI
//  

import SwiftUI
import ActivityKit
import WidgetKit

struct ContentView: View {
    
    @State private var currentID: String = ""
    @State private var currentSelection: Status = .received
    var body: some View {
        NavigationStack {
            VStack {
                Picker(selection: $currentSelection) {
                    Text("Received")
                        .tag(Status.received)
                    Text("Progress")
                        .tag(Status.progress)
                    Text("Ready")
                        .tag(Status.ready)
                } label: {
                    Text("Choose Order Status")
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                
                
                Button("Start Activity") {
                    addLiveActivity()
                }
                .padding(.top)
                
                // MARK: Removing Activity
                Button("Remove Activity") {
                    removeActivity()
                }
                .padding(.top)
            }
            .navigationTitle("Live Activities")
            .padding(15)
            .onChange(of: currentSelection) { newValue in
                // Retrieving Current Activity From the List of Phone Activities
                if let activity = Activity.activities.first(
                    where:
                        { (activity: Activity<OrderAttributes>) in
                            activity.id == currentID
                        }
                ) {
                    print("Activity Found")
                    
                    // Since I Need to Show Animation I'm Delaying Action For 2s
                    // For Demo Purpose
                    // In Real Case Scenairo Remove the Delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        var updatedState = activity.contentState
                        updatedState.status = currentSelection
                        Task {
                            await activity.update(using: updatedState)
                        }
                    }
                }
            } // End Of @inlinable public func onChange<V>(of value: V, perform action: @escaping (_ newValue: V -> Void) -> some View where V : Equatable
        } // End of NavigationStack
    } // End of body
    
    func removeActivity() {
        if let activity = Activity.activities.first(where: { (activity: Activity<OrderAttributes>) in
            activity.id == currentID
        }) {
            // FOR DEMO PURPOSE
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                Task {
                    await activity.end(using: activity.contentState, dismissalPolicy: .immediate)
                }
            }
        }
    }
    
    // NOTE: We Need to Add Key In Info.plist File
    func addLiveActivity() {
        let orderAttributes = OrderAttributes(orderNumber: 26383, orderItems: "Burger & Milk Shake")
        
        // Since It Dosen't Requires Any Initial Values
        // If Your Content State Struct Contains Initializers Then You Must Pass it Here
        let initialContentState = OrderAttributes.ContentState()
        
        do {
            let activity = try Activity<OrderAttributes>.request(
                attributes: orderAttributes,
                contentState: initialContentState,
                pushType: nil
            )
            
            // MARK: Storing CurrentID For Updating Activity
            currentID = activity.id
            print("Activity Added Successfully. id: \(activity.id)")
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
