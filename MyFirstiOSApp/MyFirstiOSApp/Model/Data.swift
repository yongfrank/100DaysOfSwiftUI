//
//  Data.swift
//  MyFirstiOSApp
//
//  Created by Frank Chu on 4/19/22.
//

import Foundation
import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var image: String
    var gradient: LinearGradient
}

var items = [
    Item(title: "SwiftUI for iOS 15", text: "A complete guide to designing for iOS 15 with videos", image: "Vector", gradient: LinearGradient(
        gradient: Gradient(stops: [
    .init(color: Color(#colorLiteral(red: 0.6313725709915161, green: 0.5490196347236633, blue: 0.8196078538894653, alpha: 1)), location: 0),
    .init(color: Color(#colorLiteral(red: 0.9843137264251709, green: 0.7607843279838562, blue: 0.9215686321258545, alpha: 1)), location: 1)]),
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5))),
    Item(title: "iOS 15", text: "A complete guide to designing for iOS 15 with videos", image: "Vector", gradient: LinearGradient(
        gradient: Gradient(stops: [
    .init(color: Color(#colorLiteral(red: 0.6313725709915161, green: 0.7686274647712708, blue: 0.9921568632125854, alpha: 1)), location: 0),
    .init(color: Color(#colorLiteral(red: 0.7607843279838562, green: 0.9137254953384399, blue: 0.9843137264251709, alpha: 1)), location: 1)]),
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5))),
    Item(title: "SwiftUI", text: "A complete guide to designing for iOS 15 with videos", image: "Vector", gradient: LinearGradient(
        gradient: Gradient(stops: [
    .init(color: Color(#colorLiteral(red: 0.9882352948188782, green: 0.7960784435272217, blue: 0.5647059082984924, alpha: 1)), location: 0),
    .init(color: Color(#colorLiteral(red: 0.8352941274642944, green: 0.4941176474094391, blue: 0.9215686321258545, alpha: 1)), location: 1)]),
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5))),
    Item(title: "iOS 15 Guide", text: "A complete guide to designing for iOS 15 with videos", image: "Vector", gradient: LinearGradient(
        gradient: Gradient(stops: [
    .init(color: Color(#colorLiteral(red: 0.26274511218070984, green: 0.9137254953384399, blue: 0.48235294222831726, alpha: 1)), location: 0),
    .init(color: Color(#colorLiteral(red: 0.21960784494876862, green: 0.9764705896377563, blue: 0.843137264251709, alpha: 1)), location: 1)]),
        startPoint: UnitPoint(x: 0, y: 0.5),
        endPoint: UnitPoint(x: 1, y: 0.5)))

]
