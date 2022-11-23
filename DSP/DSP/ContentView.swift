//
//  ContentView.swift
//  DSP
//
//  Created by Frank Chu on 10/8/22.
//

import SwiftUI
import Accelerate

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

class calculateMath {
    func fastFourierTransform() {
        let signal = (0...1024)
        
        // The length of the input
        let length = vDSP_Length(signal.count)
        
        // The power of two of two times the length of the input
        // Do not forget this factor 2.
        // public func ceil(_: Double) -> Double
        // Returns the ceiling of each element in a vector.
        let log2n = vDSP_Length(ceil(log2(Float64(length * 2))))
        
        /// A class that provides forward and inverse FFT on `DSPSplitComplex` or `DSPDoubleSplitComplex` structure.
        /// 
        /// `public class FFT<T> where T : vDSP_FourierTransformable {`
        /// Initializes a new fast Fourier transform structure.
        ///
        /// - Parameter log2n: The base-two logarithm of the maximum number of elements to be transformed.
        /// - Parameter radix: Specifies radix options.
        /// `public init?(log2n: vDSP_Length, radix: vDSP.Radix, ofType: T.Type)`
        let fftSetup = vDSP.FFT(log2n: log2n, radix: .radix2, ofType: DSPSplitComplex.self)
        
//        fftSetup?.forward(input: <#T##DSPSplitComplex#>, output: &<#T##DSPSplitComplex#>)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
