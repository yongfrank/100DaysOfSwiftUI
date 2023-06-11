//
//  NotificationPartView.swift
//  NotificationsCenter
//
//  Created by Chu Yong on 5/15/23.
//

import SwiftUI
import UserNotifications

struct NotificationPartView: View {
    @State private var showToast = false
    @State private var alertTitle = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button("Request Permission") {
                // first
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .provisional]) { success, error in
                    if success {
                        showToast.toggle()
                        alertTitle = "Success"
                    } else if let error = error {
                        showToast.toggle()
                        alertTitle = "Failed, \(error.localizedDescription)"
                        print(error.localizedDescription)
                    } else {
                        showToast.toggle()
                        alertTitle = "Failed, else"
                    }
                }
            }
            .alert(alertTitle, isPresented: $showToast) {}
            
            Button("Schedule Notification") {
                // second
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                // show this notification five seconds from now
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // choose a random identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                // add our notification request
                UNUserNotificationCenter.current().add(request)
                
                showToast.toggle()
                alertTitle = "Notification is coming"
            }
        }
        .padding()
    }

}

struct NotificationPartView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPartView()
    }
}
