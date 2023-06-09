//
//  SwiftUIViewFactory.swift
//  Douyin
//
//  Created by Frank Chu on 5/11/23.
//

import Foundation
import UIKit
import SwiftUI

class SwiftUIViewFactory: NSObject {
    @objc static func makeSwiftUIView(dismissHandler: @escaping (() -> Void)) -> UIViewController {
        return UIHostingController(rootView: ContentView(dismiss: dismissHandler))
    }
    
    @objc static func makeUIKitView() -> UIViewController {
        return UIKitViewController()
    }
    
}
