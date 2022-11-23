//
//  ContentView.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    
    /// `.environment(env)` is key point to `@EnvironmentObject`
    /// ```
    /// import SwiftUI
    /// @main
    /// struct TimeTrackingApp: App {
    ///     @ObservedObject var env = GlobalEnvironment()
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .environemntObject(env)
    ///         }
    ///     }
    /// }
    /// ```
    @EnvironmentObject var env: GlobalEnvironment
    
    @Binding var showSheet: Bool
    
    var body: some View {
        GeometryReader { geometry in
            HSplitView {
                VStack {
                    leftList
                    Spacer()
                }
                .background { Color.red }
                .frame(width: 350, height: geometry.size.height)
                
                rightView
                .padding()
                .frame(height: geometry.size.height)
            }
            .sheet(isPresented: $showSheet) {
                AddNewClockView(sheetShown: $showSheet)
                    .padding()
            }
        }
    }
    
    private var leftList: some View {
        List {
            Section {
                VStack {
                    ForEach(self.env.clocks.indices, id: \.self) { clock in
                        HStack {
                            SideBarClockLabel(clock: self.$env.clocks[clock])
                            Spacer()
                        }
                    }
                    Button(action: { showSheet.toggle() }, label: {
                        HStack {
                            Text("ADD NEW")
                            Image(systemName: "plus")
                        }
                        .padding(.top)
                    })
                        .buttonStyle(PlainButtonStyle())
                }
                .padding()
                /// `@inlinable public func background<S>(_ style: S, ignoresSafeAreaEdges edges: Edge.Set = .all) -> some View where S : ShapeStyle`
                .background(dGray.opacity(0.5))
                .cornerRadius(10)
            } header: {
                Text("Clocks")
            }
             
            /// A container view that you can use to add hierarchy to certain collection views.
            ///
            /// Use `Section` instances in views like ``List``, ``Picker``, and
            /// ``Form`` to organize content into separate sections. Each section has
            /// custom content that you provide on a per-instance basis. You can also
            /// provide headers and footers for each section.
            /// ```
            ///     extension Section where Parent : View, Content : View, Footer == EmptyView {
            ///         public init(header: Parent, @ViewBuilder content: () -> Content)
            ///     }
            /// ```
            Section {
                /// ```
                ///     public struct Button<Label> : View where Label : View {
                ///         public init(action: @escaping () -> Void, @ViewBuilder label: () -> Label)
                ///     }
                /// ```
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
                .buttonStyle(PlainButtonStyle())
//                            .buttonStyle(.plain)
            } header: {
                Text("More")
            }
            
            

        }
    }
    private var rightView: some View {
        DashboardView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(showSheet: .constant(false))
            .environmentObject(GlobalEnvironment())
    }
}
