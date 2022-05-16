//
//  D81P3_schedule_local_notifications.swift
//  HotProspects
//
//  Created by Frank Chu on 5/12/22.
//

import SwiftUI
import UserNotifications

struct D81P3_schedule_local_notifications: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }

            Button("Schedule Notification") {
                // second
                print(UUID().uuidString)
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct D81P3_schedule_local_notifications_Previews: PreviewProvider {
    static var previews: some View {
        D81P3_schedule_local_notifications()
    }
}
