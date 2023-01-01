//
//  TimeItemsApp.swift
//  TimeItems
//
//  Created by Frank Chu on 11/30/22.
//

import SwiftUI

@main
struct TimeItemsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
            /// Use this modifier to set one of the writable properties of the
            /// ``EnvironmentValues`` structure, including custom values that you
            /// create. For example, you can set the value associated with the
            /// ``EnvironmentValues/truncationMode`` key:
            ///
            ///     MyView()
            ///         .environment(\.truncationMode, .head)
            ///
            /// You then read the value inside `MyView` or one of its descendants
            /// using the ``Environment`` property wrapper:
            ///
            ///     struct MyView: View {
            ///         @Environment(\.truncationMode) var truncationMode: Text.TruncationMode
            ///
            ///         var body: some View { ... }
            ///     }
            ///
            /// SwiftUI provides dedicated view modifiers for setting most
            /// environment values, like the ``View/truncationMode(_:)``
            /// modifier which sets the ``EnvironmentValues/truncationMode`` value:
            ///
            ///     MyView()
            ///         .truncationMode(.head)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
//            extension EnvironmentValues {
//                public var managedObjectContext: NSManagedObjectContext
//            }
        }
    }
}
