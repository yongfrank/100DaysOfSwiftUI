//
//  Item.swift
//  TodoList
//
//  Created by Frank Chu on 11/9/22.
//

import Foundation

/// A type that can convert itself into and out of an external representation.
///
/// `Codable` is a type alias for the `Encodable` and `Decodable` protocols.
/// When you use `Codable` as a type or a generic constraint, it matches
/// any type that conforms to both protocols.
///
/// ```
/// public typealias Codable = Decodable & Encodable
/// ```
struct Item: Identifiable, Codable {
    /// Represents UUID strings, which can be used to uniquely identify types, interfaces, and other items.
    /// ```
    /// @available(macOS 10.8, iOS 6.0, *)
    /// public struct UUID : ReferenceConvertible, Hashable, Equatable, CustomStringConvertible, Sendable {
    ///     public init()
    /// }
    /// ```
    var id: UUID = UUID()
    var todo: String
    
}
