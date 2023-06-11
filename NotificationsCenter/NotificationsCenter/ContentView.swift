//
//  ContentView.swift
//  NotificationsCenter
//
//  Created by Chu Yong on 5/15/23.
//

import SwiftUI
import UserNotifications

struct CellModel {
    var id = UUID()
    var title: String = ""
    var content: String = ""
    var desc: String = ""
    var toggleState: Bool = false
    
    static var shared: [CellModel] = [
        .init(title: "Notifications", content: "Message Notifications", desc: "Open it")
    ]
    static var opened: [CellModel] = [
        .init(title: "IAN", content: "In-App Notifications", desc: ""),
        .init(title: "DM", content: "Direct Message", desc: ""),
        .init(title: "Marketing", content: "Marketing Message", desc: "")
    ]
}

struct ContentView: View {
    @State private var opened: [CellModel] = [
        .init(title: "IAN", content: "In-App Notifications", desc: ""),
        .init(title: "DM", content: "Direct Message", desc: ""),
        .init(title: "Marketing", content: "Marketing Message", desc: "")
    ]
    @State private var isOpen = false
    
    // https://www.hackingwithswift.com/books/ios-swiftui/how-to-be-notified-when-your-swiftui-app-moves-to-the-background
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(CellModel.shared, id: \.id) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                Text(item.content)
                                    .font(.footnote)
                            }
                            Spacer()
                            Button {
                                self.getNotificationStatus()
                            } label: {
                                Text(item.desc)
                            }
                        }
                    }
                    /*
                     guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                         return
                     }

                     if UIApplication.shared.canOpenURL(settingsUrl) {
                         UIApplication.shared.open(settingsUrl, completionHandler: nil)
                     }
                     */
                    Button("Notification Center") {
                        self.openSystemSettingsCenterFromApp()
                    }
                    if isOpen {
                        NavigationLink {
                            InsideView()
                        } label: {
                            Text(isOpen ? "Opened" : "Go And Open")
                                .foregroundColor(isOpen ? .secondary : .accentColor)
                        }
                    } else {
                        Button(isOpen ? "Opened" : "Go And Open") {
                            self.openSystemSettingsCenterFromApp()
                        }
                        .foregroundColor(isOpen ? .secondary : .accentColor)
                    }

                    Button(isOpen ? "Opened" : "Go And Open") {
                        self.openSystemSettingsCenterFromApp()
                    }
                    .foregroundColor(isOpen ? .secondary : .accentColor)
                }
                
                Section {
                    ForEach(self.opened.indices, id: \.self) { index in
                        HStack {
                            VStack(alignment: .leading) {
                                Toggle(opened[index].title, isOn: $opened[index].toggleState)
                                Text(opened[index].content)
                                    .font(.footnote)
                            }
                        }
                    }
                }
                
            }
            .alert(alertTitle, isPresented: $isShowingAlert) { }
            NotificationPartView()
        }
        .onAppear {
            print(isOpen, isSystemNotificationStatusOn())
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                print("Active")
                isSystemNotificationStatusOn()
            } else if newPhase == .inactive {
                print("Inactive")
                isSystemNotificationStatusOn()
            } else if newPhase == .background {
                print("Background")
                isSystemNotificationStatusOn()
            }
        }
    }
    
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
}

extension ContentView {
    func getNotificationStatus() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            guard (settings.authorizationStatus == .authorized)
//                    || (settings.authorizationStatus == .provisional)
            else {
                self.isShowingAlert.toggle()
                self.alertTitle = "settings.authorizationStatus != .authorized && settings.authorizationStatus == .provisional"
                return
            }

            if settings.alertSetting == .enabled {
                // Schedule an alert-only notification.
                self.isShowingAlert.toggle()
                self.alertTitle = "settings.alertSetting == .enabled"
            } else {
                // Schedule a notification with a badge and sound.
                self.isShowingAlert.toggle()
                self.alertTitle = "settings.alertSetting != .enabled"
            }
        }
    }
    
    /// is System Notification Status On
    /// - Returns: true - on false - off
    ///
    /// [Apple Developers](https://developer.apple.com/documentation/usernotifications/asking_permission_to_use_notifications#2941986)
    func isSystemNotificationStatusOn() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard (settings.authorizationStatus == .authorized) || (settings.authorizationStatus == .provisional) else {
                self.isOpen = false
                return
            }
            self.isOpen = true
        }
    }
    
    /// System Settings
    ///
    /// [Apple Developers](https://stackoverflow.com/questions/28152526/how-do-i-open-phone-settings-when-a-button-is-clicked)
    func openSystemSettingsCenterFromApp() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct InsideView: View {
    var body: some View {
        List {
            Text("新消息推送通知已开启")
        }
    }
}
