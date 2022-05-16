//
//  ContentView.swift
//  MultilanguageString
//
//  Created by Frank Chu on 4/17/22.
//

import SwiftUI

struct MyCustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.73793*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.67575*width, y: 0.15772*height), control1: CGPoint(x: 0.74562*width, y: 0.05784*height), control2: CGPoint(x: 0.71751*width, y: 0.11597*height))
        path.addCurve(to: CGPoint(x: 0.49836*width, y: 0.22767*height), control1: CGPoint(x: 0.63399*width, y: 0.19951*height), control2: CGPoint(x: 0.56546*width, y: 0.23196*height))
        path.addCurve(to: CGPoint(x: 0.5618*width, y: 0.07487*height), control1: CGPoint(x: 0.48922*width, y: 0.17098*height), control2: CGPoint(x: 0.52309*width, y: 0.11183*height))
        path.addCurve(to: CGPoint(x: 0.73793*width, y: 0), control1: CGPoint(x: 0.60496*width, y: 0.03313*height), control2: CGPoint(x: 0.67775*width, y: 0.002*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.98646*width, y: 0.7246*height))
        path.addCurve(to: CGPoint(x: 0.82622*width, y: 0.52481*height), control1: CGPoint(x: 0.97922*width, y: 0.72217*height), control2: CGPoint(x: 0.82788*width, y: 0.67154*height))
        path.addCurve(to: CGPoint(x: 0.95496*width, y: 0.3371*height), control1: CGPoint(x: 0.82491*width, y: 0.40242*height), control2: CGPoint(x: 0.94467*width, y: 0.34227*height))
        path.addCurve(to: CGPoint(x: 0.95546*width, y: 0.33685*height), control1: CGPoint(x: 0.95517*width, y: 0.33699*height), control2: CGPoint(x: 0.95536*width, y: 0.33691*height))
        path.addCurve(to: CGPoint(x: 0.73675*width, y: 0.23886*height), control1: CGPoint(x: 0.8852*width, y: 0.25187*height), control2: CGPoint(x: 0.77575*width, y: 0.2402*height))
        path.addCurve(to: CGPoint(x: 0.57938*width, y: 0.26681*height), control1: CGPoint(x: 0.67978*width, y: 0.23409*height), control2: CGPoint(x: 0.62451*width, y: 0.2521*height))
        path.addCurve(to: CGPoint(x: 0.50783*width, y: 0.28415*height), control1: CGPoint(x: 0.55072*width, y: 0.27615*height), control2: CGPoint(x: 0.52617*width, y: 0.28415*height))
        path.addCurve(to: CGPoint(x: 0.43378*width, y: 0.26659*height), control1: CGPoint(x: 0.48738*width, y: 0.28415*height), control2: CGPoint(x: 0.46212*width, y: 0.27587*height))
        path.addCurve(to: CGPoint(x: 0.31049*width, y: 0.24122*height), control1: CGPoint(x: 0.39667*width, y: 0.25443*height), control2: CGPoint(x: 0.35428*width, y: 0.24053*height))
        path.addCurve(to: CGPoint(x: 0.06304*width, y: 0.36503*height), control1: CGPoint(x: 0.20894*width, y: 0.24244*height), control2: CGPoint(x: 0.11538*width, y: 0.28998*height))
        path.addCurve(to: CGPoint(x: 0.13883*width, y: 0.86274*height), control1: CGPoint(x: -0.04233*width, y: 0.51618*height), control2: CGPoint(x: 0.03615*width, y: 0.7401*height))
        path.addCurve(to: CGPoint(x: 0.32764*width, y: 0.98777*height), control1: CGPoint(x: 0.18909*width, y: 0.9227*height), control2: CGPoint(x: 0.24899*width, y: 0.99023*height))
        path.addCurve(to: CGPoint(x: 0.41372*width, y: 0.96872*height), control1: CGPoint(x: 0.36283*width, y: 0.98663*height), control2: CGPoint(x: 0.38786*width, y: 0.97783*height))
        path.addCurve(to: CGPoint(x: 0.52357*width, y: 0.94733*height), control1: CGPoint(x: 0.44357*width, y: 0.95823*height), control2: CGPoint(x: 0.47454*width, y: 0.94733*height))
        path.addCurve(to: CGPoint(x: 0.62846*width, y: 0.96809*height), control1: CGPoint(x: 0.57038*width, y: 0.94733*height), control2: CGPoint(x: 0.59999*width, y: 0.95791*height))
        path.addCurve(to: CGPoint(x: 0.72091*width, y: 0.98655*height), control1: CGPoint(x: 0.65564*width, y: 0.9778*height), control2: CGPoint(x: 0.6818*width, y: 0.98715*height))
        path.addCurve(to: CGPoint(x: 0.90396*width, y: 0.86518*height), control1: CGPoint(x: 0.80241*width, y: 0.98531*height), control2: CGPoint(x: 0.85412*width, y: 0.92536*height))
        path.addCurve(to: CGPoint(x: 0.98651*width, y: 0.72522*height), control1: CGPoint(x: 0.95978*width, y: 0.79781*height), control2: CGPoint(x: 0.98383*width, y: 0.73252*height))
        path.addCurve(to: CGPoint(x: 0.98672*width, y: 0.72468*height), control1: CGPoint(x: 0.98662*width, y: 0.72497*height), control2: CGPoint(x: 0.98667*width, y: 0.72479*height))
        path.addCurve(to: CGPoint(x: 0.98646*width, y: 0.7246*height), control1: CGPoint(x: 0.9867*width, y: 0.72467*height), control2: CGPoint(x: 0.98662*width, y: 0.72464*height))
        path.closeSubpath()
        return path
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            MyCustomShape()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
