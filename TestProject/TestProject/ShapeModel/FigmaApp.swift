//
//  FigmaApp.swift
//  TestProject
//
//  Created by Frank Chu on 4/16/22.
//

import Foundation

import SwiftUI

struct FigmaApp: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.5*width, y: 0.5*height))
        path.addCurve(to: CGPoint(x: 0.57322*width, y: 0.38215*height), control1: CGPoint(x: 0.5*width, y: 0.4558*height), control2: CGPoint(x: 0.52634*width, y: 0.41341*height))
        path.addCurve(to: CGPoint(x: 0.75*width, y: 0.33333*height), control1: CGPoint(x: 0.62011*width, y: 0.35089*height), control2: CGPoint(x: 0.68369*width, y: 0.33333*height))
        path.addCurve(to: CGPoint(x: 0.92678*width, y: 0.38215*height), control1: CGPoint(x: 0.81631*width, y: 0.33333*height), control2: CGPoint(x: 0.87989*width, y: 0.35089*height))
        path.addCurve(to: CGPoint(x: width, y: 0.5*height), control1: CGPoint(x: 0.97366*width, y: 0.41341*height), control2: CGPoint(x: width, y: 0.4558*height))
        path.addCurve(to: CGPoint(x: 0.92678*width, y: 0.61785*height), control1: CGPoint(x: width, y: 0.5442*height), control2: CGPoint(x: 0.97366*width, y: 0.58659*height))
        path.addCurve(to: CGPoint(x: 0.75*width, y: 0.66667*height), control1: CGPoint(x: 0.87989*width, y: 0.64911*height), control2: CGPoint(x: 0.81631*width, y: 0.66667*height))
        path.addCurve(to: CGPoint(x: 0.57322*width, y: 0.61785*height), control1: CGPoint(x: 0.68369*width, y: 0.66667*height), control2: CGPoint(x: 0.62011*width, y: 0.64911*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.5*height), control1: CGPoint(x: 0.52634*width, y: 0.58659*height), control2: CGPoint(x: 0.5*width, y: 0.5442*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.83333*height))
        path.addCurve(to: CGPoint(x: 0.07322*width, y: 0.71548*height), control1: CGPoint(x: 0, y: 0.78913*height), control2: CGPoint(x: 0.02634*width, y: 0.74674*height))
        path.addCurve(to: CGPoint(x: 0.25*width, y: 0.66667*height), control1: CGPoint(x: 0.12011*width, y: 0.68423*height), control2: CGPoint(x: 0.1837*width, y: 0.66667*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.66667*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.83333*height))
        path.addCurve(to: CGPoint(x: 0.42678*width, y: 0.95118*height), control1: CGPoint(x: 0.5*width, y: 0.87754*height), control2: CGPoint(x: 0.47366*width, y: 0.91993*height))
        path.addCurve(to: CGPoint(x: 0.25*width, y: height), control1: CGPoint(x: 0.37989*width, y: 0.98244*height), control2: CGPoint(x: 0.31631*width, y: height))
        path.addCurve(to: CGPoint(x: 0.07322*width, y: 0.95118*height), control1: CGPoint(x: 0.1837*width, y: height), control2: CGPoint(x: 0.12011*width, y: 0.98244*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.83333*height), control1: CGPoint(x: 0.02634*width, y: 0.91993*height), control2: CGPoint(x: 0, y: 0.87754*height))
        path.addLine(to: CGPoint(x: 0, y: 0.83333*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.5*width, y: 0))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.33333*height))
        path.addLine(to: CGPoint(x: 0.75*width, y: 0.33333*height))
        path.addCurve(to: CGPoint(x: 0.92678*width, y: 0.28452*height), control1: CGPoint(x: 0.81631*width, y: 0.33333*height), control2: CGPoint(x: 0.87989*width, y: 0.31577*height))
        path.addCurve(to: CGPoint(x: width, y: 0.16667*height), control1: CGPoint(x: 0.97366*width, y: 0.25326*height), control2: CGPoint(x: width, y: 0.21087*height))
        path.addCurve(to: CGPoint(x: 0.92678*width, y: 0.04882*height), control1: CGPoint(x: width, y: 0.12246*height), control2: CGPoint(x: 0.97366*width, y: 0.08007*height))
        path.addCurve(to: CGPoint(x: 0.75*width, y: 0), control1: CGPoint(x: 0.87989*width, y: 0.01756*height), control2: CGPoint(x: 0.81631*width, y: 0))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.16667*height))
        path.addCurve(to: CGPoint(x: 0.07322*width, y: 0.28452*height), control1: CGPoint(x: 0, y: 0.21087*height), control2: CGPoint(x: 0.02634*width, y: 0.25326*height))
        path.addCurve(to: CGPoint(x: 0.25*width, y: 0.33333*height), control1: CGPoint(x: 0.12011*width, y: 0.31577*height), control2: CGPoint(x: 0.1837*width, y: 0.33333*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.33333*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0))
        path.addLine(to: CGPoint(x: 0.25*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.07322*width, y: 0.04882*height), control1: CGPoint(x: 0.1837*width, y: 0), control2: CGPoint(x: 0.12011*width, y: 0.01756*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.16667*height), control1: CGPoint(x: 0.02634*width, y: 0.08007*height), control2: CGPoint(x: 0, y: 0.12246*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.5*height))
        path.addCurve(to: CGPoint(x: 0.07322*width, y: 0.61785*height), control1: CGPoint(x: 0, y: 0.5442*height), control2: CGPoint(x: 0.02634*width, y: 0.58659*height))
        path.addCurve(to: CGPoint(x: 0.25*width, y: 0.66667*height), control1: CGPoint(x: 0.12011*width, y: 0.64911*height), control2: CGPoint(x: 0.1837*width, y: 0.66667*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.66667*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.33333*height))
        path.addLine(to: CGPoint(x: 0.25*width, y: 0.33333*height))
        path.addCurve(to: CGPoint(x: 0.07322*width, y: 0.38215*height), control1: CGPoint(x: 0.1837*width, y: 0.33333*height), control2: CGPoint(x: 0.12011*width, y: 0.35089*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.5*height), control1: CGPoint(x: 0.02634*width, y: 0.41341*height), control2: CGPoint(x: 0, y: 0.4558*height))
        path.addLine(to: CGPoint(x: 0, y: 0.5*height))
        path.closeSubpath()
        return path
    }
}

struct FigmaApp_Previews: PreviewProvider {
    static var previews: some View {
        FigmaApp()
            .frame(width: 380, height: 570)
            .foregroundStyle(.linearGradient(colors: [.blue, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
            .padding()
    }
}
