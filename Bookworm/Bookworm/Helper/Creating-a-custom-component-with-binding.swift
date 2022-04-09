//
//  Creating-a-custom-component-with-binding.swift
//  Bookworm
//
//  Created by Frank Chu on 4/5/22.
//  https://www.hackingwithswift.com/books/ios-swiftui/creating-a-custom-component-with-binding

import SwiftUI

struct PushButtonView: View {
    
    var body: some View {
        Button("Remember Me") {
            
        }
    }
}

struct Creating_a_custom_component_with_binding: View {
    
    @State private var rememberMe = false
    
    var body: some View {
        VStack {
            
            PushButtonView()
            
            Toggle("Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct Creating_a_custom_component_with_binding_Previews: PreviewProvider {
    static var previews: some View {
        Creating_a_custom_component_with_binding()
    }
}
