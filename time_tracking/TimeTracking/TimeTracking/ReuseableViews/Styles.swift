//
//  Styles.swift
//  TimeTracking
//
//  Created by Frank Chu on 10/22/22.
//

import Foundation
import SwiftUI

struct PlainButtonStyle: ButtonStyle {
    /// ```
    /// public protocol ButtonStyle {
    ///     associatedtype Body : View
    ///     @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
    ///     typealias Configuration = ButtonStyleConfiguration
    /// }
    func makeBody(configuration: Self.Configuration) -> some View {
        /// ```
        /// public struct ButtonStyleConfiguration {
        ///     public let label: ButtonStyleConfiguration.Label
        /// }
        return configuration.label
    }
}

/// ```
/// extention PrimitiveButtonStype where Self == PlainButtonStyle {
///     public static var plain: PlainButtonStyle { get }
/// }

//extension PrimitiveButtonStyle where Self == style {
//    public static var ss: style {
//
//    }
//}
//struct style : PrimitiveButtonStyle {
//    public func makeBody(configuration: Configuration) -> some View {
//        return configuration.label
//    }
//}
